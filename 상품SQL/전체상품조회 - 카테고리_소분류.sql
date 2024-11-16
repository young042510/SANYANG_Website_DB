-- 상품조회 - 상세카테고리 
CREATE OR REPLACE VIEW vw_product_category_list2
AS
SELECT B.category AS 카테고리,
       B.sub_category AS 상세카테고리,
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



-- 상세카테고리 32가지
-- 1)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '크로와상%';
-- 2) 
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '파이';
-- 3)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '쿠키류';
-- 4)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '스콘';
-- 5)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '소포장';
-- 6)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리  LIKE '식빵도우%';
-- 7)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '미니%';
-- 8)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '브라우니';
-- 9)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '휘낭시에';
-- 10)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '캬늘레';
-- 11)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리  =  '기타';
--12)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리  =  '버터';
--13)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리  =  '아이스크림';
--14)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리  =  '치즈';
--15)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '크림%';
--16)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '피자소스';
--17)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '기타소스%';
--18)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '치킨';
--19)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '소시지';
--20)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '햄';
--21)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '베이컨%';
--22)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '견과류';
--23)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '앙금';
--24)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '콜드브루';
--25)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 LIKE '커피재료%';
--26)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '제철과일';
--27)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '냉동과일';
--28)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '화덕피자';
--29)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '스프';
--30)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '설탕';
--31)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '당류';
--32)
SELECT *
FROM vw_product_category_list2
WHERE 상세카테고리 = '파스타소스';

