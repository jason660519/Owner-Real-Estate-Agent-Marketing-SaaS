# Claude Code 配置快速指南

## 🎯 檔案放置位置指南

根據業界最佳實踐，Claude Code 相關文檔的標準放置位置：

### 主要說明文檔
- **[CLAUDE_SETUP.md](./CLAUDE_SETUP.md)** → 專案根目錄（完整使用指南）
- **[.claude/README.md](./.claude/README.md)** → .claude 目錄（快速參考）
- **[README.md](./README.md)** → 專案根目錄（已添加 Claude Code 介紹）

### 配置檔案結構
```
專案根目錄/
├── CLAUDE_SETUP.md          ✅ 主要說明文檔
├── .mcp.json                ✅ MCP 服務配置
├── .claude/
│   ├── README.md            ✅ 快速參考
│   ├── settings.json        ✅ 主要設定
│   ├── settings.md          ✅ 設定說明
│   ├── agents/              ✅ 專業代理商
│   ├── commands/            ✅ 自定義命令
│   ├── hooks/               ✅ 自動化腳本
│   └── skills/              ✅ 技能模組
└── .github/workflows/       ✅ CI/CD 自動化
```

## 🌟 業界標準做法

### 大型科技公司慣例
1. **Google/Microsoft**: 主說明放根目錄，詳細配置放子目錄
2. **Meta/Netflix**: 使用 `SETUP.md` 或 `GETTING_STARTED.md` 命名
3. **AWS/Azure**: 配置檔案統一放 `.config/` 或工具特定目錄

### 開源專案慣例
- **主 README.md**: 簡要介紹，連結到詳細文檔
- **SETUP.md / GETTING_STARTED.md**: 完整設置指南
- **工具目錄**: 各工具專用配置（如 `.github/`, `.docker/`, `.claude/`）

## ✅ 推薦給團隊的文檔結構

1. **[CLAUDE_SETUP.md](./CLAUDE_SETUP.md)** - 所有開發者必讀
2. **[.claude/README.md](./.claude/README.md)** - 日常開發快速參考
3. **專案 README.md** - 包含 Claude Code 介紹和連結

這樣的結構確保：
- 新進工程師容易找到完整指南
- 資深工程師有快速參考
- 配置檔案組織清晰
- 符合業界標準慣例

## 📋 給工程師的使用清單

### 新進工程師
1. ✅ 閱讀 [CLAUDE_SETUP.md](./CLAUDE_SETUP.md)
2. ✅ 設置開發環境
3. ✅ 執行 `/real-estate-onboard` 命令
4. ✅ 嘗試使用技能和代理商

### 日常開發
1. ✅ 參考 [.claude/README.md](./.claude/README.md)
2. ✅ 使用分支保護（避免直接編輯 main）
3. ✅ 利用自動格式化和測試
4. ✅ 在需要時呼叫專業代理商

所有文檔已按照業界標準放置，團隊成員可以輕鬆找到和使用！ 🚀