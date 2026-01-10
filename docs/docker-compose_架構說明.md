# Docker Compose 架構說明

## 服務架構總覽

根據 `專案架構.md` 重新設計的 Docker Compose 配置，完整反映專案所需的基礎設施。

## 服務清單

### 1. 資料庫服務

#### PostgreSQL (主資料庫) ✅ **已啟用**
- **容器名稱**: `owner_saas_db`
- **端口**: `5432`
- **用途**:
  - 儲存謄本 PDF 解析後的 JSON 資料（JSONB 類型）
  - 物件基本資料（地址、坪數、屋主資訊等）
  - 物件與照片的關聯關係
  - 租賃合約、租客資料、財務記錄等業務資料
- **健康檢查**: 已配置，確保服務正常啟動

#### ClickHouse (分析型資料庫) ⚠️ **可選，已註解**
- **容器名稱**: `owner_saas_clickhouse`
- **端口**: `8123` (HTTP), `9000` (Native)
- **用途**:
  - 財務報表統計（季度/年度收入分析）
  - 跨物件數據聚合查詢
  - 市場趨勢分析
- **狀態**: 初期不需要，待分析需求增加時再啟用

### 2. 物件儲存服務

#### MinIO ✅ **已啟用**
- **容器名稱**: `owner_saas_minio`
- **端口**: 
  - `9000`: API endpoint
  - `9001`: Console UI (管理介面)
- **用途**:
  - 儲存房東的物件照片
  - 物件說明文檔
  - 合約檔案
- **預設帳號**: 
  - User: `minioadmin`
  - Password: `minioadmin`
  - **⚠️ 生產環境請務必修改！**
- **健康檢查**: 已配置

### 3. 快取與會話儲存

#### Redis ⚠️ **可選，已註解**
- **容器名稱**: `owner_saas_redis`
- **端口**: `6379`
- **用途**:
  - LLM API 響應快取（降低 API 成本）
  - Rasa 對話狀態儲存
  - Django 快取（物件列表、報表等）
  - Celery 任務隊列（未來使用）
- **狀態**: MVP 階段不需要，效能優化時再啟用

### 4. AI 服務

#### Rasa ✅ **已啟用**
- **容器名稱**: `owner_saas_rasa`
- **端口**: `5005` (HTTP API)
- **用途**:
  - AI 語音助手框架
  - 對話管理與意圖識別
  - 自然語言處理
- **依賴**: 
  - PostgreSQL (用於 tracker store)
  - Redis (可選，用於對話狀態快取)
- **注意**: 需要建立 `./rasa` 目錄和相關配置檔案

### 5. 後端服務

#### Django API Backend ✅ **已啟用**
- **容器名稱**: `owner_saas_backend`
- **端口**: `8000`
- **用途**:
  - RESTful API 服務
  - 業務邏輯處理
  - 與 AI Agents 整合
- **環境變數**:
  - `DATABASE_URL`: PostgreSQL 連接
  - `MINIO_ENDPOINT`: MinIO 服務地址
  - `RASA_API_URL`: Rasa 服務地址
- **依賴**: 
  - PostgreSQL (必須)
  - MinIO (必須)
  - Rasa (必須)
  - Redis (可選)

### 6. 前端服務

#### Frontend (Expo Web / Next.js) ✅ **已啟用**
- **容器名稱**: `owner_saas_frontend`
- **端口**: `3000`
- **用途**:
  - Web Dashboard (React / Expo Web)
  - 用戶介面
- **環境變數**:
  - `NEXT_PUBLIC_API_URL`: Backend API 地址
  - `NEXT_PUBLIC_RASA_URL`: Rasa API 地址

### 7. 可選服務

#### Cloudflare Tunnel ⚠️ **可選，已註解**
- **用途**: 提供安全的公網訪問，無需開放端口
- **狀態**: 需要時再啟用

## 服務依賴關係

```
Frontend
  └─> Backend
        ├─> PostgreSQL (必須)
        ├─> MinIO (必須)
        └─> Rasa (必須)

Rasa
  └─> PostgreSQL (tracker store)
  └─> Redis (可選，對話狀態快取)

Backend
  └─> Redis (可選，快取和 session)
```

## 啟動順序

Docker Compose 會自動處理服務依賴和啟動順序：

1. **基礎設施層**:
   - PostgreSQL (資料庫)
   - MinIO (物件儲存)
   - Redis (可選)

2. **AI 服務層**:
   - Rasa (等待 PostgreSQL 就緒)

3. **應用層**:
   - Backend (等待所有依賴就緒)
   - Frontend (等待 Backend 就緒)

## 環境變數配置

### 開發環境
- 使用預設值（已配置在 docker-compose.yml）
- 所有服務使用預設帳號密碼

### 生產環境
**⚠️ 必須修改以下環境變數：**

1. **PostgreSQL**:
   ```yaml
   POSTGRES_PASSWORD=your_secure_password
   ```

2. **MinIO**:
   ```yaml
   MINIO_ROOT_USER=your_username
   MINIO_ROOT_PASSWORD=your_secure_password
   ```

3. **Django**:
   ```yaml
   SECRET_KEY=your_django_secret_key
   DEBUG=0
   ```

4. **Redis** (如啟用):
   ```yaml
   # 建議使用 Redis AUTH
   ```

## 資料持久化

### Volumes
- `postgres_data`: PostgreSQL 資料
- `minio_data`: MinIO 物件儲存
- `clickhouse_data`: ClickHouse 資料（可選）

### 備份建議
- 定期備份 PostgreSQL 資料
- 定期備份 MinIO 物件儲存
- 使用 Docker volume 備份工具

## 網路配置

所有服務都在 `owner_net` 網路中，可以通過服務名稱互相訪問：
- `db`: PostgreSQL
- `minio`: MinIO
- `redis`: Redis (如啟用)
- `rasa`: Rasa
- `backend`: Django Backend
- `frontend`: Frontend

## 端口映射

| 服務 | 端口 | 用途 |
|------|------|------|
| PostgreSQL | 5432 | 資料庫連接 |
| MinIO API | 9000 | 物件儲存 API |
| MinIO Console | 9001 | 管理介面 |
| Redis | 6379 | 快取服務 (可選) |
| Rasa | 5005 | AI 助手 API |
| Backend | 8000 | Django API |
| Frontend | 3000 | Web 介面 |

## 健康檢查

已為以下服務配置健康檢查：
- ✅ PostgreSQL
- ✅ MinIO
- ⚠️ Redis (如啟用)

健康檢查確保服務正常啟動後，依賴服務才會啟動。

## 下一步

### 1. 建立必要的目錄結構
```bash
mkdir -p rasa backend frontend
```

### 2. 建立 Rasa 配置
- `rasa/Dockerfile`
- `rasa/endpoints.yml`
- `rasa/credentials.yml`

### 3. 建立 Backend 配置
- `backend/Dockerfile`
- Django 專案結構

### 4. 建立 Frontend 配置
- `frontend/Dockerfile`
- Next.js 或 Expo Web 專案

### 5. 啟動服務
```bash
docker-compose up -d
```

### 6. 驗證服務
- 訪問 `http://localhost:3000` (Frontend)
- 訪問 `http://localhost:8000` (Backend API)
- 訪問 `http://localhost:9001` (MinIO Console)
- 訪問 `http://localhost:5005` (Rasa API)

## 故障排除

### 服務無法啟動
1. 檢查日誌: `docker-compose logs [service_name]`
2. 檢查健康狀態: `docker-compose ps`
3. 檢查端口衝突: `netstat -an | grep [port]`

### 連接問題
1. 確認服務在同一網路: `docker network inspect owner_net`
2. 使用服務名稱而非 localhost 連接
3. 檢查環境變數配置

### 資料持久化問題
1. 檢查 volume 掛載: `docker volume ls`
2. 檢查權限: `docker volume inspect [volume_name]`

## 參考文件

- [專案架構.md](../專案架構.md)
- [軟硬體開發架構與互動流程圖.md](../軟硬體開發架構與互動流程圖.md)
- [Redis_必要性分析.md](./Redis_必要性分析.md)
