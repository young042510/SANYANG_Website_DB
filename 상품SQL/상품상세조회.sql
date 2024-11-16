-- 상품 상세 조회 VIEW
CREATE OR REPLACE VIEW vw_product_detail
AS
SELECT   b.filename AS 상품이미지 ,
         a.product_name AS 상품명,
         d.brand_name AS 브랜드,
         a.summary AS 상품요약정보,
         a.price AS 판매가,
         a.product_code AS 상품코드,
         a.howtodelivery  AS 배송방법,
         e.basic_charge || '(' ||e.free_condition|| ')'  AS 배송비
  FROM product a 
  JOIN image b ON a.img_code = b.img_code
  JOIN p_brand c ON a.product_code = c.product_code
  JOIN brand d ON c.brand_code = d.brand_code
  JOIN delivery_charge e ON a.delivery_charge_code = e.delivery_charge_code;
-- 상품 상세 조회
SELECT * FROM vw_product_detail;
