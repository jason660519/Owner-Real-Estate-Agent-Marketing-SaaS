# 架構圖文檔

本資料夾包含專案的系統架構圖和互動流程圖。

## 文件列表

- **軟硬體開發架構與互動流程圖.md** - 完整的架構圖和流程圖文檔（Markdown 格式）
- **mermaid-preview.html** - 架構圖的 HTML 預覽版本（可在瀏覽器中直接查看）

## 主要更新

根據專案架構討論，已進行以下更新：

### 1. 資料庫架構
- ✅ **主資料庫**：PostgreSQL（使用 JSONB 儲存謄本資料）
- ⚠️ **分析型資料庫**：ClickHouse（可選，用於財務報表）

### 2. 後端架構
- ✅ **Backend API**：Node.js + Express/Fastify + LangChain
- ✅ **Rasa**：Python（AI 對話服務，獨立運行）

### 3. 流程圖更新
- ✅ 所有流程圖中的資料庫已更新為 PostgreSQL
- ✅ 添加了 Backend Process (Node.js) 節點
- ✅ 明確標示 ClickHouse 為可選的分析型資料庫

## 查看方式

### 方式一：Markdown 文件
直接在編輯器中打開 `軟硬體開發架構與互動流程圖.md`，支援 Mermaid 的編輯器會自動渲染圖表。

### 方式二：HTML 預覽
在瀏覽器中打開 `mermaid-preview.html`，可以查看完整的互動式架構圖。

## 相關文檔

- [專案架構](../專案架構.md)
- [資料庫選型建議](../資料庫選型建議.md)
- [Docker Compose 架構說明](../docker-compose_架構說明.md)
