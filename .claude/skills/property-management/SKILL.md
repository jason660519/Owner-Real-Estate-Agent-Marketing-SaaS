# Property Management Skill

房地產物業管理系統開發技能，專注於物業 CRUD 操作、狀態管理和業務邏輯。

## 核心概念

### 物業數據模型
```typescript
interface Property {
  id: string;
  ownerId: string;
  title: string;
  description: string;
  propertyType: PropertyType;
  price: number;
  location: Location;
  amenities: Amenity[];
  images: PropertyImage[];
  status: PropertyStatus;
  createdAt: Date;
  updatedAt: Date;
}

enum PropertyType {
  APARTMENT = "apartment",
  HOUSE = "house",
  CONDO = "condo",
  TOWNHOUSE = "townhouse",
  STUDIO = "studio"
}

enum PropertyStatus {
  AVAILABLE = "available",
  RENTED = "rented",
  PENDING = "pending",
  MAINTENANCE = "maintenance",
  DRAFT = "draft"
}
```

### 後端 API 設計
```python
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional

router = APIRouter(prefix="/api/v1/properties", tags=["properties"])

@router.post("/", response_model=PropertyResponse)
async def create_property(
    property_data: PropertyCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # 驗證用戶權限
    if current_user.role not in [UserRole.OWNER, UserRole.AGENT]:
        raise HTTPException(403, "Insufficient permissions")
    
    # 驗證物業數據
    property_obj = Property(**property_data.dict(), owner_id=current_user.id)
    db.add(property_obj)
    db.commit()
    db.refresh(property_obj)
    
    return property_obj

@router.get("/search", response_model=List[PropertyResponse])
async def search_properties(
    filters: PropertySearchFilters = Depends(),
    db: Session = Depends(get_db)
):
    query = db.query(Property)
    
    # 應用搜尋過濾器
    if filters.location:
        query = query.filter(Property.location.contains(filters.location))
    
    if filters.min_price:
        query = query.filter(Property.price >= filters.min_price)
    
    if filters.max_price:
        query = query.filter(Property.price <= filters.max_price)
    
    if filters.property_type:
        query = query.filter(Property.property_type == filters.property_type)
    
    return query.limit(50).all()
```

### 前端組件架構
```typescript
// PropertyCard.tsx
interface PropertyCardProps {
  property: Property;
  onEdit?: (property: Property) => void;
  onDelete?: (propertyId: string) => void;
  viewOnly?: boolean;
}

export const PropertyCard: React.FC<PropertyCardProps> = ({
  property,
  onEdit,
  onDelete,
  viewOnly = false
}) => {
  const { data: currentUser } = useCurrentUser();
  const canEdit = currentUser?.id === property.ownerId || currentUser?.role === 'AGENT';

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden">
      {/* 物業圖片輪播 */}
      <PropertyImageCarousel images={property.images} />
      
      {/* 物業基本信息 */}
      <div className="p-6">
        <div className="flex justify-between items-start mb-2">
          <h3 className="text-xl font-semibold">{property.title}</h3>
          <PropertyStatusBadge status={property.status} />
        </div>
        
        <p className="text-gray-600 mb-4">{property.description}</p>
        
        {/* 價格和位置 */}
        <div className="flex justify-between items-center">
          <span className="text-2xl font-bold text-green-600">
            ${property.price.toLocaleString()}/月
          </span>
          <span className="text-sm text-gray-500">
            {property.location.city}, {property.location.state}
          </span>
        </div>
        
        {/* 操作按鈕 */}
        {!viewOnly && canEdit && (
          <div className="mt-4 flex gap-2">
            <button
              onClick={() => onEdit?.(property)}
              className="flex-1 bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700"
            >
              編輯
            </button>
            <button
              onClick={() => onDelete?.(property.id)}
              className="flex-1 bg-red-600 text-white py-2 px-4 rounded-md hover:bg-red-700"
            >
              刪除
            </button>
          </div>
        )}
      </div>
    </div>
  );
};
```

### 狀態管理
```typescript
// usePropertyManagement.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { propertyApi } from '../services/api';

export const usePropertyManagement = () => {
  const queryClient = useQueryClient();

  // 獲取用戶物業列表
  const {
    data: properties,
    isLoading,
    error
  } = useQuery({
    queryKey: ['properties'],
    queryFn: propertyApi.getProperties,
  });

  // 創建物業
  const createPropertyMutation = useMutation({
    mutationFn: propertyApi.createProperty,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['properties'] });
    },
  });

  // 更新物業
  const updatePropertyMutation = useMutation({
    mutationFn: ({ id, data }: { id: string; data: PropertyUpdate }) =>
      propertyApi.updateProperty(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['properties'] });
    },
  });

  // 刪除物業
  const deletePropertyMutation = useMutation({
    mutationFn: propertyApi.deleteProperty,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['properties'] });
    },
  });

  return {
    properties,
    isLoading,
    error,
    createProperty: createPropertyMutation.mutate,
    updateProperty: updatePropertyMutation.mutate,
    deleteProperty: deletePropertyMutation.mutate,
    isCreating: createPropertyMutation.isPending,
    isUpdating: updatePropertyMutation.isPending,
    isDeleting: deletePropertyMutation.isPending,
  };
};
```

### 表單驗證
```typescript
// PropertyForm.tsx
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const propertySchema = z.object({
  title: z.string().min(1, '標題是必填的').max(100, '標題不能超過100字'),
  description: z.string().min(1, '描述是必填的').max(1000, '描述不能超過1000字'),
  propertyType: z.nativeEnum(PropertyType, {
    errorMap: () => ({ message: '請選擇物業類型' }),
  }),
  price: z.number().min(1, '價格必須大於0'),
  location: z.object({
    address: z.string().min(1, '地址是必填的'),
    city: z.string().min(1, '城市是必填的'),
    state: z.string().min(1, '州/省是必填的'),
    zipCode: z.string().min(1, '郵編是必填的'),
    latitude: z.number().optional(),
    longitude: z.number().optional(),
  }),
  amenities: z.array(z.string()).optional(),
});

type PropertyFormData = z.infer<typeof propertySchema>;

export const PropertyForm: React.FC<PropertyFormProps> = ({
  property,
  onSubmit,
  onCancel
}) => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
    setValue,
    watch
  } = useForm<PropertyFormData>({
    resolver: zodResolver(propertySchema),
    defaultValues: property ? {
      title: property.title,
      description: property.description,
      propertyType: property.propertyType,
      price: property.price,
      location: property.location,
      amenities: property.amenities?.map(a => a.name) || [],
    } : undefined,
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
      {/* 基本信息 */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <FormField
          label="物業標題"
          error={errors.title}
          required
        >
          <input
            {...register('title')}
            type="text"
            className="w-full px-3 py-2 border border-gray-300 rounded-md"
            placeholder="豪華三房兩廳公寓"
          />
        </FormField>

        <FormField
          label="物業類型"
          error={errors.propertyType}
          required
        >
          <select
            {...register('propertyType')}
            className="w-full px-3 py-2 border border-gray-300 rounded-md"
          >
            <option value="">請選擇</option>
            {Object.values(PropertyType).map(type => (
              <option key={type} value={type}>
                {getPropertyTypeLabel(type)}
              </option>
            ))}
          </select>
        </FormField>
      </div>

      {/* 價格 */}
      <FormField
        label="月租金 (NT$)"
        error={errors.price}
        required
      >
        <input
          {...register('price', { valueAsNumber: true })}
          type="number"
          min="0"
          step="1000"
          className="w-full px-3 py-2 border border-gray-300 rounded-md"
          placeholder="25000"
        />
      </FormField>

      {/* 描述 */}
      <FormField
        label="物業描述"
        error={errors.description}
        required
      >
        <textarea
          {...register('description')}
          rows={4}
          className="w-full px-3 py-2 border border-gray-300 rounded-md resize-vertical"
          placeholder="詳細描述物業特色、周邊環境等..."
        />
      </FormField>

      {/* 地址信息 */}
      <LocationForm register={register} errors={errors.location} />

      {/* 設施 */}
      <AmenitiesSelector
        selectedAmenities={watch('amenities') || []}
        onChange={(amenities) => setValue('amenities', amenities)}
      />

      {/* 提交按鈕 */}
      <div className="flex justify-end gap-4">
        <button
          type="button"
          onClick={onCancel}
          className="px-6 py-2 text-gray-700 border border-gray-300 rounded-md hover:bg-gray-50"
        >
          取消
        </button>
        <button
          type="submit"
          disabled={isSubmitting}
          className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50"
        >
          {isSubmitting ? '處理中...' : property ? '更新' : '創建'}
        </button>
      </div>
    </form>
  );
};
```

## 最佳實踐

### 1. 數據驗證
- 前端和後端都需要驗證
- 使用 TypeScript 和 Pydantic 確保類型安全
- 驗證業務規則（價格範圍、必填字段等）

### 2. 權限控制
- 業主只能管理自己的物業
- 代理商可以管理授權的物業
- 租客和買家只能查看公開物業

### 3. 搜尋優化
- 使用數據庫索引優化查詢
- 實現分頁和限制結果數量
- 考慮使用 Elasticsearch 進行全文搜索

### 4. 圖片管理
- 壓縮和優化圖片大小
- 使用 CDN 加速圖片載入
- 實現懶載入和預覽功能

### 5. 緩存策略
- 緩存熱門搜尋結果
- 使用 Redis 緩存用戶會話
- 實現適當的緩存失效機制