# Claude Code 配置使用指南

## 概述

本專案已配置完整的 Claude Code 開發環境，專門針對房地產 SaaS 應用優化。此配置提供智能代碼助理、自動化品質檢查、房地產業務邏輯驗證等功能。

## 📋 目錄結構

```
Owner Real Estate Agent SaaS/
├── .mcp.json                    # MCP 服務器配置
├── .claude/                     # Claude Code 配置目錄
│   ├── settings.json           # 主要設定檔（hooks、環境變數）
│   ├── settings.md             # 設定說明文檔
│   ├── agents/                 # 專業代理商
│   │   ├── real-estate-code-reviewer.md
│   │   └── real-estate-architect.md
│   ├── commands/               # 自定義命令
│   │   ├── real-estate-onboard.md
│   │   └── real-estate-code-quality.md
│   ├── hooks/                  # 自動化腳本
│   │   └── real-estate-skill-eval.sh
│   └── skills/                 # 專門技能模組
│       ├── property-management/
│       ├── user-authentication/
│       └── README.md
├── .github/workflows/          # GitHub Actions 自動化
│   └── real-estate-code-quality.yml
└── CLAUDE_SETUP.md            # 本文檔
```

## 🚀 快速開始

### 1. 前置需求

確保您的開發環境已安裝：
- Claude Code（VS Code 擴展）
- Docker 和 Docker Compose
- Node.js 18+ 和 npm
- Python 3.11+ 和 pip
- Git

### 2. 環境變數設置

創建 `.env` 檔案並配置以下環境變數：

```bash
# 數據庫連接
DATABASE_URL=postgresql://user:password@localhost:5432/realestate_saas

# Redis 緩存
REDIS_URL=redis://localhost:6379

# JWT 認證
SECRET_KEY=your-super-secret-key-here
ALGORITHM=HS256

# 第三方服務（可選）
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
SLACK_BOT_TOKEN=xoxb-xxxxxxxxxxxxx
NOTION_API_KEY=secret_xxxxxxxxxxxxx

# 文件存儲
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
S3_BUCKET_NAME=realestate-files
```

### 3. 啟用 Claude Code

1. 在 VS Code 中安裝 Claude Code 擴展
2. 打開專案根目錄
3. Claude Code 會自動識別 `.mcp.json` 和 `.claude/` 配置

## 🛠️ 核心功能

### 自動化 Hooks

#### PreToolUse（編輯前檢查）
- **主分支保護**: 防止在 `main` 分支直接編輯檔案
- **建議**: 創建功能分支，如 `feature/property-listing`

```bash
# 正確的開發流程
git checkout -b feature/user-authentication
# 現在可以安全編輯檔案
```

#### PostToolUse（編輯後自動化）

**代碼格式化**：
- 前端檔案 (`.js`, `.jsx`, `.ts`, `.tsx`) → Prettier
- 後端檔案 (`.py`) → Black

**依賴管理**：
- `frontend/package.json` 變更 → 自動執行 `npm install`
- `backend/requirements.txt` 變更 → 自動執行 `pip install`

**測試執行**：
- 測試檔案變更 → 自動運行相關測試
- TypeScript 檔案 → 自動類型檢查

### 智能技能建議

系統會根據您的開發內容自動建議相關技能：

- **物業相關** → property-management 技能
- **認證相關** → user-authentication 技能
- **前端開發** → frontend-components 技能
- **API 開發** → api-development 技能

## 👨‍💼 專業代理商

### Real Estate Code Reviewer
專門審查房地產應用代碼的高級審查員。

**使用方式**：
```
@real-estate-code-reviewer 請審查我的物業搜尋 API
```

**檢查項目**：
- 房地產業務邏輯正確性
- 用戶權限和安全性
- 數據庫查詢優化
- API 設計最佳實踐

### Real Estate Architect
系統架構設計專家，專注於可擴展的房地產平台架構。

**使用方式**：
```
@real-estate-architect 幫我設計多租戶物業管理架構
```

**擅長領域**：
- 微服務架構設計
- 數據庫架構優化
- 性能和擴展性規劃
- 容器化部署策略

## 🎯 自定義命令

### Onboarding 命令
```
/real-estate-onboard
```
為新團隊成員提供完整的專案介紹和開發環境設置指導。

### 代碼品質檢查
```
/real-estate-code-quality
```
執行全面的代碼品質檢查，包括：
- 前後端代碼規範檢查
- 房地產業務邏輯驗證
- 安全性掃描
- 測試覆蓋率分析

## 🏗️ 技能模組使用

### Property Management 技能
處理物業相關的開發任務。

**觸發關鍵字**：property, listing, rent, lease, tenant, landlord

**使用範例**：
```
請使用 property-management 技能創建一個物業卡片組件
```

### User Authentication 技能  
處理用戶認證和角色管理功能。

**觸發關鍵字**：auth, login, user, role, permission

**使用範例**：
```
請幫我實現支持多角色的用戶註冊功能
```

## 🔧 開發工作流程

### 1. 創建功能分支
```bash
git checkout -b feature/property-search
```

### 2. 開始開發
- Claude Code 會根據您的工作自動建議相關技能
- 編輯檔案時會自動格式化和類型檢查
- 測試檔案會自動運行相關測試

### 3. 代碼審查
```
@real-estate-code-reviewer 請審查我的變更
```

### 4. 品質檢查
```
/real-estate-code-quality
```

### 5. 提交和合併
```bash
git add .
git commit -m "feat: implement property search functionality"
git push origin feature/property-search
# 創建 Pull Request
```

## 🎨 最佳實踐

### 分支命名約定
- `feature/property-*` - 物業相關功能
- `feature/user-*` - 用戶相關功能  
- `feature/agent-*` - 代理商功能
- `feature/search-*` - 搜尋功能
- `bugfix/*` - 錯誤修復
- `hotfix/*` - 緊急修復

### 提交訊息格式
```
<type>(<scope>): <subject>

feat(property): add advanced search filters
fix(auth): resolve JWT token expiration issue
docs(api): update property endpoint documentation
test(user): add authentication flow tests
```

### 代碼審查重點
- 房地產業務邏輯正確性
- 用戶權限和數據安全
- 性能優化（特別是搜尋查詢）
- 響應式設計和無障礙性
- 測試覆蓋率

## 🔍 故障排除

### Hook 執行失敗
如果自動化 hook 執行失敗：

1. 檢查檔案權限：
```bash
chmod +x .claude/hooks/real-estate-skill-eval.sh
```

2. 確認依賴已安裝：
```bash
cd frontend && npm install
cd backend && pip install -r requirements.txt
```

### 格式化問題
如果代碼格式化失敗：

```bash
# 前端
cd frontend && npx prettier --write src/

# 後端  
cd backend && python -m black .
```

### 測試失敗
如果測試執行失敗：

```bash
# 前端測試
cd frontend && npm test

# 後端測試
cd backend && pytest
```

## 📚 進階配置

### 自定義技能
在 `.claude/skills/` 目錄下創建新的技能模組：

```markdown
# .claude/skills/payment-processing/SKILL.md
# Payment Processing Skill
...
```

### 環境特定配置
為不同環境創建特定配置：

```json
// .claude/settings.development.json
{
  "env": {
    "DEBUG_MODE": "1",
    "SKIP_TESTS": "0"
  }
}
```

### GitHub Actions 自定義
修改 `.github/workflows/real-estate-code-quality.yml` 來調整 CI/CD 流程。

## 🤝 團隊協作

### 新成員入職
1. 閱讀本文檔
2. 設置開發環境
3. 執行 `/real-estate-onboard` 命令
4. 完成第一個小功能來熟悉工作流程

### 代碼審查流程
1. 創建 Pull Request
2. 自動運行品質檢查
3. 使用 `@real-estate-code-reviewer` 進行代碼審查
4. 修復發現的問題
5. 獲得批准後合併

### 知識分享
- 定期分享 Claude Code 使用技巧
- 記錄常見問題和解決方案
- 持續改進技能模組和配置

## 📞 獲得幫助

如果遇到問題：

1. 查看 `.claude/settings.md` 了解詳細配置
2. 使用 `/real-estate-onboard` 獲得指導
3. 在團隊頻道詢問其他開發者
4. 查看 GitHub Actions 日誌了解 CI/CD 問題
5. 聯繫 DevOps 團隊獲得技術支援

---

**版本**: v1.0.0  
**更新時間**: 2026年1月8日  
**維護者**: 房地產 SaaS 開發團隊