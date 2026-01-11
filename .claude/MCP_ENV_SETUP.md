# MCP 環境變數設定指南

## 概述
此文件列出所有需要在 Mac mini OS 系統環境變數中設定的 MCP 服務器配置變數。

## 必要環境變數

### 1. PostgreSQL 資料庫
```bash
export POSTGRES_CONNECTION_STRING="postgresql://username:password@localhost:5432/rental_management_dev"
```
- **說明**: PostgreSQL 資料庫連接字串
- **格式**: `postgresql://[使用者]:[密碼]@[主機]:[端口]/[資料庫名稱]`
- **範例**: `postgresql://admin:secret123@localhost:5432/rental_management_dev`

### 2. GitHub 整合
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_github_token_here"
export GITHUB_OWNER="jason66"
export GITHUB_REPO="owner-real-estate-agent-saas"
```
- **GITHUB_PERSONAL_ACCESS_TOKEN**: GitHub Personal Access Token
  - 需要權限: `repo`, `read:org`, `read:user`
  - 取得方式: GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
- **GITHUB_OWNER**: GitHub 帳號名稱
- **GITHUB_REPO**: Repository 名稱

### 3. SQLite 資料庫
```bash
export SQLITE_DB_PATH="/Users/jason66/Owner Real Estate Agent SaaS/dev/local.db"
```
- **說明**: SQLite 資料庫檔案路徑
- **用途**: 本地開發和測試

### 4. Brave Search API
```bash
export BRAVE_API_KEY="your_brave_api_key_here"
```
- **說明**: Brave Search API 金鑰
- **用途**: 市場研究和競爭分析
- **取得方式**: https://brave.com/search/api/

## 設定方法

### 方法 1: 永久設定 (推薦)

編輯你的 shell 配置檔案 (`~/.zshrc` 或 `~/.bash_profile`):

```bash
# 打開配置檔案
nano ~/.zshrc

# 添加以下內容
export POSTGRES_CONNECTION_STRING="postgresql://username:password@localhost:5432/rental_management_dev"
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here"
export GITHUB_OWNER="jason66"
export GITHUB_REPO="owner-real-estate-agent-saas"
export SQLITE_DB_PATH="/Users/jason66/Owner Real Estate Agent SaaS/dev/local.db"
export BRAVE_API_KEY="your_brave_api_key_here"

# 儲存後重新載入配置
source ~/.zshrc
```

### 方法 2: 使用 `.env` 檔案

1. 創建 `.env` 檔案在專案根目錄
2. 添加環境變數（參考上面的格式）
3. 在啟動 Claude Code 前執行: `source .env`

### 方法 3: macOS 系統層級設定

```bash
# 使用 launchctl 設定系統環境變數
launchctl setenv POSTGRES_CONNECTION_STRING "your_value"
launchctl setenv GITHUB_PERSONAL_ACCESS_TOKEN "your_value"
# ... 其他變數
```

**注意**: 使用 `launchctl` 設定後需要重新登入或重啟才會生效。

## 驗證設定

設定完成後，可以使用以下命令驗證：

```bash
# 檢查單個環境變數
echo $POSTGRES_CONNECTION_STRING
echo $GITHUB_PERSONAL_ACCESS_TOKEN

# 檢查所有相關環境變數
env | grep -E "(POSTGRES|GITHUB|SQLITE|BRAVE)"
```

## 安全性建議

1. **不要提交敏感資訊**: 確保 `.env` 檔案已加入 `.gitignore`
2. **定期更新 Token**: 建議每 3-6 個月更新 GitHub token
3. **最小權限原則**: 只授予必要的權限
4. **使用密碼管理器**: 將敏感資訊儲存在安全的密碼管理器中

## 故障排除

### Claude Code 無法連接到 MCP 服務器

1. 確認環境變數已正確設定
2. 重啟 terminal
3. 檢查變數格式是否正確
4. 確認相關服務（如 PostgreSQL）正在運行

### GitHub MCP 連接失敗

1. 驗證 GitHub token 是否有效
2. 確認 token 有正確的權限範圍
3. 檢查 repository 名稱是否正確

### PostgreSQL 連接失敗

1. 確認 PostgreSQL 服務正在運行: `pg_isready`
2. 驗證連接字串格式
3. 測試連接: `psql $POSTGRES_CONNECTION_STRING`

## 更新日誌

- 2026-01-12: 初始版本，將所有硬編碼值改為環境變數引用
