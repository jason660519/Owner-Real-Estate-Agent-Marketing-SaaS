# Real Estate SaaS Claude Code Settings

## 專案概述
此配置專為房地產 SaaS 專案設計，包含前端（React/TypeScript）和後端（Python/FastAPI）的完整開發工作流。

## 環境變數

- `INSIDE_CLAUDE_CODE`: "1" - 表示代碼在 Claude Code 環境中運行
- `BASH_DEFAULT_TIMEOUT_MS`: Bash 命令預設超時時間 (7 分鐘)
- `BASH_MAX_TIMEOUT_MS`: Bash 命令最大超時時間
- `REAL_ESTATE_SAAS_MODE`: "1" - 房地產 SaaS 專案標識

## Hooks 配置

### UserPromptSubmit（用戶提示提交）

- **房地產技能評估**: 分析提示並建議相關的房地產開發技能
  - **腳本**: `.claude/hooks/real-estate-skill-eval.sh`
  - **行為**: 匹配關鍵字、檔案路徑和模式，建議相關技能

### PreToolUse（工具使用前）

- **主分支保護**: 防止在 main 分支上進行編輯 (5秒超時)
  - **觸發條件**: 使用 Edit、MultiEdit 或 Write 工具編輯檔案前
  - **行為**: 當在 main 分支時阻止檔案編輯，建議創建功能分支（如：feature/property-listing, feature/user-auth）

### PostToolUse（工具使用後）

1. **代碼格式化**: 自動格式化 JS/TS/Python 檔案 (30秒超時)
   - **觸發條件**: 編輯 `.js`, `.jsx`, `.ts`, `.tsx`, `.py` 檔案後
   - **前端命令**: `npx prettier --write`
   - **後端命令**: `python -m black`
   - **行為**: 格式化代碼，如發現錯誤則顯示反饋

2. **前端依賴安裝**: package.json 變更後自動安裝 (60秒超時)
   - **觸發條件**: 編輯 `frontend/package.json` 檔案後
   - **命令**: `cd frontend && npm install`
   - **行為**: 安裝前端依賴，如安裝失敗則編輯失敗

3. **後端依賴安裝**: requirements.txt 變更後自動安裝 (90秒超時)
   - **觸發條件**: 編輯 `backend/requirements.txt` 檔案後  
   - **命令**: `cd backend && pip install -r requirements.txt`
   - **行為**: 安裝後端依賴，如安裝失敗則編輯失敗

4. **房地產組件測試**: 測試檔案變更後運行測試 (120秒超時)
   - **前端觸發條件**: 編輯 `.test.js`, `.test.jsx`, `.test.ts`, `.test.tsx` 檔案後
   - **前端命令**: `cd frontend && npm test -- --findRelatedTests <file> --passWithNoTests`
   - **後端觸發條件**: 編輯後端 `test*.py` 檔案後
   - **後端命令**: `cd backend && python -m pytest <file> -v`
   - **行為**: 運行相關測試，顯示結果，非阻塞性

5. **TypeScript 檢查**: 房地產組件類型檢查 (30秒超時)
   - **觸發條件**: 編輯 `.ts`, `.tsx` 檔案後
   - **命令**: `cd frontend && npx tsc --noEmit`
   - **行為**: 僅顯示前幾個錯誤，非阻塞性

## Hook 回應格式

```json
{
  "feedback": "要顯示的訊息",
  "suppressOutput": true,  // 可選：隱藏輸出
  "block": true,          // 可選：阻止操作
  "message": "阻止原因"    // 阻止時的說明訊息
}
```

## 房地產專案特殊考量

- **分支命名建議**: feature/property-*, feature/user-*, feature/agent-*, bugfix/*
- **測試重點**: 物業邏輯、用戶流程、代理商功能、租賃管理
- **代碼品質**: 前端使用 Prettier，後端使用 Black
- **容器化支援**: 包含 Docker 相關的 MCP 服務器