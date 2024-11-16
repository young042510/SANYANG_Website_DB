-- 전체 상품 베스트 30
CREATE OR REPLACE VIEW vw_product_best
AS
SELECT ROW_NUMBER() OVER(ORDER BY A.GRADE) AS 순위,
       E.filename AS 상품이미지,
       C.brand_name AS 브랜드명,
       A.product_name AS 상품명,
       A.summary AS 상품요약,
       A.price AS 상품가격,
       A.grade AS 상품평점,
       A.review_num AS 리뷰수
FROM PRODUCT A JOIN P_BRAND B ON A.PRODUCT_CODE = B.PRODUCT_CODE
               JOIN BRAND C ON B.BRAND_CODE = C.BRAND_CODE
               JOIN image E ON a.img_code = E.img_code
               WHERE ROWNUM <= 30;
            
-- BEST 30 출력
SELECT *
FROM vw_product_best;

-- 카테고리별 베스트 상품
CREATE OR REPLACE VIEW vw_product_category_best
AS
SELECT  RANK() OVER(PARTITION BY B.category ORDER BY  E.filename ) AS 순위,
       B.category AS 카테고리,
       E.filename AS 상품이미지,
       D.brand_name AS 브랜드명,
       A.product_name AS 상품명,
       A.summary AS 상품요약,
       A.price AS 상품가격,
       A.grade AS 상품평점,
       A.review_num AS 리뷰수
FROM product A JOIN p_category B ON A.category_code = B.category_code 
JOIN p_brand C ON A.product_code = C.product_code
JOIN brand D ON C.brand_code = D.brand_code
JOIN image E ON a.img_code = E.img_code;

-- 카테고리 대분류 베스트 상품조회
SELECT * FROM vw_product_category_best
WHERE 카테고리 = '간편식';

SELECT * FROM vw_product_category_best
WHERE 카테고리 = '냉동완제품';

SELECT * FROM vw_product_category_best
WHERE 카테고리 = '소스';

SELECT * FROM vw_product_category_best
WHERE 카테고리 = '유제품';

SELECT * FROM vw_product_category_best
WHERE 카테고리 = '제철과일';

SELECT * FROM vw_product_category_best
WHERE 카테고리 LIKE '육가공품';

SELECT * FROM vw_product_category_best
WHERE 카테고리 LIKE '커피%';

SELECT * FROM vw_product_category_best
WHERE 카테고리 LIKE '설탕%';