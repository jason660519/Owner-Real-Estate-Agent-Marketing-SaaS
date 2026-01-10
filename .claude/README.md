# Claude Code 配置總覽

本專案使用 Claude Code 進行智能輔助開發。完整的設置指南請參考 [CLAUDE_SETUP.md](../CLAUDE_SETUP.md)。

## 快速參考

### 🎯 主要功能
- **自動代碼格式化**: Prettier (前端) + Black (後端)
- **智能技能建議**: 根據開發內容推薦相關技能
- **專業代理商**: 房地產代碼審查員和系統架構師
- **分支保護**: 防止直接在主分支編輯
- **自動化測試**: 檔案變更後自動運行相關測試

### 🚀 常用命令
```bash
# 新手指南
/real-estate-onboard

# 代碼品質檢查
/real-estate-code-quality

# 呼叫專業代理商
@real-estate-code-reviewer 請審查我的代碼
@real-estate-architect 幫我設計系統架構
```

### 🏠 房地產專用技能
- **property-management**: 物業管理開發
- **user-authentication**: 多角色用戶認證
- **search-filtering**: 搜尋和過濾功能
- **payment-processing**: 支付系統整合

### 📁 配置檔案
- `.mcp.json` - MCP 服務器配置
- `.claude/settings.json` - 主要設定和 hooks
- `.claude/agents/` - 專業代理商
- `.claude/skills/` - 技能模組庫
- `.github/workflows/` - CI/CD 自動化

### 🔧 開發工作流程
1. 創建功能分支：`git checkout -b feature/property-listing`
2. 開始開發（自動格式化和檢查）
3. 使用 Claude Code 代理商審查代碼
4. 運行品質檢查命令
5. 提交 Pull Request

## 詳細說明

請參考 [CLAUDE_SETUP.md](../CLAUDE_SETUP.md) 獲得完整的使用指南和設置說明。