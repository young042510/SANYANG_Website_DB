-- 1) 전체 상품조회 VIEW
CREATE OR REPLACE VIEW vw_product_list
AS
SELECT E.filename AS 상품이미지,
       C.brand_name AS 브랜드명,
       A.product_name AS 상품명,
       A.summary AS 상품요약,
       A.price AS 상품가격,
       A.grade AS 상품평점,
       A.review_num AS 리뷰수
FROM PRODUCT A JOIN P_BRAND B ON A.PRODUCT_CODE = B.PRODUCT_CODE
               JOIN BRAND C ON B.BRAND_CODE = C.BRAND_CODE
               JOIN image E ON a.img_code = E.img_code
   	     ORDER BY A.product_code ASC;

-- 전체상품조회
SELECT *
FROM vw_product_list;
-- 상품 상품명 조회
SELECT *
FROM vw_product_list
ORDER BY 상품명;
-- 상품 낮은가격 조회
SELECT *
FROM vw_product_list
ORDER BY 상품가격 ASC;
-- 상품 높은가격 조회
SELECT *
FROM vw_product_list
ORDER BY 상품가격 DESC;
-- 인기상품 조회
SELECT *
FROM vw_product_list
ORDER BY 상품평점 DESC;
-- 사용후기 조회
SELECT *
FROM vw_product_list
ORDER BY 리뷰수 DESC;
-- 정기 배송 조회
SELECT * FROM vw_product_detail WHERE 상품명 LIKE '[정기배송]%';

-- 2) 상품 신상품 조회 - 상품 등록일자 순
SELECT E.filename AS 상품이미지,
       C.brand_name AS 브랜드명,
       A.product_name AS 상품명,
       A.summary AS 상품요약,
       A.price AS 상품가격,
       A.grade AS 상품평점,
       A.review_num AS 리뷰수
FROM PRODUCT A JOIN P_BRAND B ON A.PRODUCT_CODE = B.PRODUCT_CODE
               JOIN BRAND C ON B.BRAND_CODE = C.BRAND_CODE
               JOIN image E ON a.img_code = E.img_code
            ORDER BY B.regist_date DESC;

