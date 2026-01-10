# Expo 後端架構分析

## 重要澄清：Expo 的定位

### Expo 是什麼？
- ✅ **前端框架**：用於開發 React Native 移動應用和 Web 應用
- ✅ **跨平台**：一套代碼可以運行在 iOS、Android 和 Web
- ❌ **不是後端框架**：Expo 無法處理服務器端業務邏輯

### Expo 的職責
1. **用戶界面 (UI)**：移動端和 Web 端的界面
2. **客戶端邏輯**：表單驗證、狀態管理、UI 交互
3. **API 調用**：通過 HTTP/WebSocket 與後端服務通信

## 為什麼需要後端 API？

根據您的專案架構，需要後端 API 來處理：

### 1. **業務邏輯處理** ⚠️ **必須**
- 物件資料管理（CRUD 操作）
- 租客資料管理
- 租賃合約管理
- 財務報表計算
- 用戶認證與授權

### 2. **資料庫操作** ⚠️ **必須**
- 與 PostgreSQL 交互（查詢、插入、更新）
- 謄本 JSON 資料的儲存與查詢
- 複雜的關聯查詢（物件 + 照片 + 屋主）

### 3. **檔案管理** ⚠️ **必須**
- 與 MinIO 交互（上傳照片、文檔）
- 檔案上傳下載處理
- 檔案權限管理

### 4. **AI 服務整合** ⚠️ **必須**
- 與 Rasa 對話服務整合
- LLM API 調用（GPT-4o, Claude）
- AI Agents 的協調（Website Creator, Legal Agent 等）
- 文件解析（IDP）的處理

### 5. **第三方服務整合** ⚠️ **必須**
- Stripe Connect（金流）
- Twilio/Resend（簡訊/Email）
- DocuSeal（電子簽章）

### 6. **安全性** ⚠️ **必須**
- API 認證與授權
- 敏感資料的保護
- 防止客戶端直接訪問資料庫

## 架構分析

根據您的 `軟硬體開發架構與互動流程圖.md`：

```
Expo App (前端)
    ↓ HTTPS/WebSocket
Rasa (AI 對話)
    ↓
LLM Proxy Orchestrator (LangChain/Node.js)  ← 這是後端！
    ↓
AI Agents (Website Creator, Legal, Accountant, etc.)
    ↓
PostgreSQL / MinIO
```

**關鍵發現**：架構圖中提到了 **"LLM Proxy Orchestrator (LangChain/Node.js)"**，這表明後端應該使用 **Node.js**，而不是 Django！

## 後端框架選擇建議

### 方案一：Node.js + Express/Fastify（推薦）✅

**符合架構設計**：
- 架構圖明確提到 "LangChain/Node.js"
- 與 Expo 前端技術棧一致（都是 JavaScript/TypeScript）
- 適合 AI/LLM 整合（LangChain 原生支援 Node.js）

**優勢**：
- ✅ 與 Expo 技術棧統一（JavaScript/TypeScript）
- ✅ LangChain 原生支援，AI 整合更容易
- ✅ 非同步處理能力強（適合 AI API 調用）
- ✅ 生態系統豐富（npm 套件）
- ✅ 開發效率高（前後端共用類型定義）

**實作範例**：
```javascript
// backend/server.js
const express = require('express');
const { LangChain } = require('langchain');

const app = express();

// 物件管理 API
app.get('/api/properties', async (req, res) => {
  // 查詢 PostgreSQL
  const properties = await db.query('SELECT * FROM properties');
  res.json(properties);
});

// AI Agent 整合
app.post('/api/generate-listing', async (req, res) => {
  const agent = new WebsiteCreatorAgent();
  const result = await agent.generate(req.body);
  res.json(result);
});
```

### 方案二：Python + FastAPI（可選）

**適合場景**：
- 團隊更熟悉 Python
- 需要深度整合 Rasa（Rasa 是 Python 框架）
- 需要複雜的數據處理（Pandas, NumPy）

**優勢**：
- ✅ 與 Rasa 整合更容易（都是 Python）
- ✅ AI/ML 生態系統強大
- ✅ FastAPI 效能優秀，自動生成 API 文檔
- ✅ 類型提示支援好

**缺點**：
- ❌ 與 Expo 技術棧不一致（需要維護兩套代碼）
- ❌ LangChain 在 Python 和 Node.js 之間需要額外整合

### 方案三：Python + Django（目前配置）

**不推薦的原因**：
- ❌ 架構圖明確提到 Node.js，不是 Python
- ❌ Django 較重，對於 AI/LLM 整合不如 FastAPI 靈活
- ❌ 與 Expo 技術棧不一致

**如果堅持使用 Django**：
- 需要額外的 Node.js 服務來處理 LLM Proxy
- 增加系統複雜度

## 推薦架構

### 架構一：純 Node.js 後端（推薦）✅

```
┌─────────────────┐
│  Expo App       │ (前端)
│  (React Native) │
└────────┬────────┘
         │ HTTPS/WebSocket
         ↓
┌─────────────────┐
│  Node.js API    │ (後端)
│  Express/Fastify│
│  + LangChain    │
└────────┬────────┘
         │
    ┌────┴────┐
    ↓         ↓
┌────────┐ ┌────────┐
│  Rasa  │ │PostgreSQL│
│  (AI)  │ │  MinIO   │
└────────┘ └────────┘
```

**優點**：
- 技術棧統一（JavaScript/TypeScript）
- 符合架構設計
- 開發效率高

### 架構二：混合架構（可選）

```
┌─────────────────┐
│  Expo App       │
└────────┬────────┘
         │
    ┌────┴────┐
    ↓         ↓
┌────────┐ ┌────────┐
│ Node.js│ │  Rasa  │
│  API   │ │ (Python)│
└────────┘ └────────┘
    │         │
    └────┬────┘
         ↓
    PostgreSQL
```

**優點**：
- Rasa 保持 Python（原生支援）
- Node.js 處理業務邏輯和 LLM 整合

## 具體建議

### 根據您的專案架構，建議：

1. **後端使用 Node.js + Express/Fastify** ✅
   - 符合架構圖中的 "LangChain/Node.js"
   - 與 Expo 技術棧統一
   - 適合 AI/LLM 整合

2. **保留 Rasa（Python）** ✅
   - Rasa 是 Python 框架，需要單獨運行
   - 通過 HTTP API 與 Node.js 後端通信

3. **移除 Django** ❌
   - 不符合架構設計
   - 增加不必要的複雜度

## 實作建議

### Node.js 後端結構

```
backend/
├── server.js              # Express 服務器
├── routes/
│   ├── properties.js      # 物件管理 API
│   ├── tenants.js         # 租客管理 API
│   ├── contracts.js       # 合約管理 API
│   └── ai-agents.js       # AI Agents API
├── services/
│   ├── database.js        # PostgreSQL 連接
│   ├── minio.js           # MinIO 連接
│   ├── rasa.js            # Rasa API 客戶端
│   └── llm.js             # LLM API 整合
├── agents/
│   ├── WebsiteCreator.js  # 網站生成 Agent
│   ├── LegalAgent.js      # 法務 Agent
│   └── AccountantAgent.js # 會計 Agent
└── package.json
```

### Docker Compose 調整

```yaml
# Backend: Node.js API
backend:
  build: ./backend
  container_name: owner_saas_backend
  command: node server.js
  ports:
    - "8000:8000"
  environment:
    - NODE_ENV=development
    - DATABASE_URL=postgres://postgres:postgres@db:5432/ownersaas
    - MINIO_ENDPOINT=minio:9000
    - RASA_API_URL=http://rasa:5005
  depends_on:
    - db
    - minio
    - rasa
```

## 總結

### 回答您的問題：

**Q: 使用 Expo 架構，還需要其他 API 嗎？比如 Django, FastAPI？**

**A: 是的，必須需要後端 API！**

**原因**：
1. Expo 只是前端框架，無法處理後端業務邏輯
2. 需要後端來處理資料庫、檔案、AI 服務整合
3. 根據您的架構圖，應該使用 **Node.js**，而不是 Django 或 FastAPI

**建議**：
- ✅ 使用 **Node.js + Express/Fastify** 作為後端 API
- ✅ 保留 **Rasa (Python)** 作為 AI 對話服務
- ❌ 移除 **Django**（不符合架構設計）

**技術棧統一的好處**：
- 前後端共用 TypeScript 類型定義
- 開發效率更高
- 維護成本更低
- 符合架構設計（LangChain/Node.js）
