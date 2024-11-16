-- 전체상품조회 - 카테고리별
CREATE OR REPLACE VIEW vw_product_category_list
AS
SELECT B.category AS 카테고리,
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
JOIN image E ON a.img_code = E.img_code
ORDER BY A.product_code desc;
-- 카테고리 - 냉동베이커리
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '냉동베이커리';
-- 카테고리 - 냉동완제품
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '냉동완제품';
-- 카테고리 - 유제품
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '유제품';
-- 카테고리 - 소스
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '소스';
-- 카테고리 - 육가공품
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '육가공품';
-- 카테고리 - 베이킹재료
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '베이킹재료';
-- 카테고리 - 커피&커피재료
SELECT *
FROM vw_product_category_list
WHERE 카테고리 LIKE '커피%';
-- 카테고리 - 제철과일
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '제철과일';
-- 카테고리 - 간편식
SELECT *
FROM vw_product_category_list
WHERE 카테고리 = '간편식';
-- 카테고리 -설탕&당류
SELECT *
FROM vw_product_category_list
WHERE 카테고리 LIKE '설탕%';


