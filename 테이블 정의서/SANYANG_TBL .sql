--------------------------------------------------------
--프로젝트 계정생성
CREATE USER proj2 IDENTIFIED BY ss501;
GRANT CREATE SESSION TO proj2;
GRANT RESOURCE TO proj2;
--계정 권한 확인
SELECT *
FROM user_sys_privs;
--------------------------------------------------------
--계정의 모든 테이블삭제 쿼리
BEGIN
    FOR cur_tbl IN ( SELECT table_name FROM tabs )
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE '
                                    || cur_tbl.table_name || 
                                    ' CASCADE CONSTRAINTS';
    END LOOP;
END;
--확인커리
SELECT *
FROM tabs;
--------------------------------------------------------
--------------------------------------------------------
/* 회원정보 */
CREATE TABLE memberinfo (
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	pw VARCHAR2(30) NOT NULL, /* 비밀번호 */
	name NVARCHAR2(15) NOT NULL, /* 이름 */
	gender VARCHAR2(6) NOT NULL, /* 성별 */
	zip_code VARCHAR2(10) NOT NULL, /* 우편번호 */
	address NVARCHAR2(100) NOT NULL, /* 주소 */
	general_tel VARCHAR2(22), /* 일반전화 */
	cell_tel VARCHAR2(22) NOT NULL, /* 휴대전화 */
	email VARCHAR2(100), /* 이메일 */
	birthdate DATE NOT NULL, /* 생년월일 */
	date_solar_lunar VARCHAR2(6) NOT NULL, /* 양력/음력 */
	area VARCHAR2(6) NOT NULL, /* 지역 */
	occupation VARCHAR2(12), /* 종사업종 */
	solo_info VARCHAR2(1), /* 개인정보이용동의 */
	sms_receiving VARCHAR2(1) DEFAULT 'N' NOT NULL, /* sms 수신여부 */
	mail_receiving VARCHAR2(1) DEFAULT 'N' NOT NULL, /* 메일 수신여부 */
	lifetime_member VARCHAR2(1) DEFAULT 'N' NOT NULL, /* 평생회원 */
	grade_name VARCHAR2(15) NOT NULL /* 등급명 */
);
----  회원정보 제약 조건 추가 ----
ALTER TABLE memberinfo
	ADD CONSTRAINT PK_memberinfo PRIMARY KEY (member_no)
	ADD	CONSTRAINT CK_memberinfo_generaltel	
        CHECK (REGEXP_LIKE  (general_tel, '^0\d{6,11}$'))
	ADD	CONSTRAINT CK_memberinfo_celltel    
        CHECK (REGEXP_LIKE  (cell_tel, '^(010|011)\d{8}$'))
	ADD	CONSTRAINT CK_memberinfo_email		
        CHECK (REGEXP_LIKE (email,'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'))
	ADD	CONSTRAINT CK_memberinfo_datesollunar
		CHECK (date_solar_lunar  IN ('양력','음력'))
	ADD	CONSTRAINT CK_memberinfo_soloinfo
		CHECK (solo_info IN ('N','Y'))
	ADD	CONSTRAINT CK_memberinfo_smsreceive
		CHECK (sms_receiving IN ('N','Y'))
	ADD	CONSTRAINT CK_memberinfo_mailreceive
		CHECK (mail_receiving IN ('N','Y'))
	ADD	CONSTRAINT CK_memberinfo_lifetime
		CHECK (lifetime_member IN ('N','Y'));

/* 적립금 */
CREATE TABLE savedmoney (
	order_no NUMBER(10) NOT NULL, /* 주문번호 */
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	point NUMBER NOT NULL, /* 적립금 */
	not_point NUMBER NOT NULL, /* 미가용적립금 */
	available_date DATE NOT NULL, /* 사용가능예정일 */
	order_date DATE DEFAULT SYSDATE NOT NULL, /* 주문날짜 */
	content VARCHAR2(100) /* 내용 */
);
----  적립금 제약 조건 추가 ----
ALTER TABLE savedmoney
	ADD	CONSTRAINT PK_savedmoney
		PRIMARY KEY (order_no);

/* 멤버십 */
CREATE TABLE membership (
	grade_name VARCHAR2(15) NOT NULL, /* 등급명 */
	grade_con NUMBER(6) NOT NULL, /* 등급조건 */
	regular_discount VARCHAR2(10) NOT NULL, /* 상시할인 */
	purchase_point VARCHAR2(10) NOT NULL, /* 구매적립 */
	coupon_no VARCHAR2(105) /* 쿠폰번호 */
);
----  멤버십 제약 조건 추가 ----
ALTER TABLE membership
	ADD	CONSTRAINT PK_membership PRIMARY KEY (grade_name);

/* 쿠폰 */
CREATE TABLE coupon (
	coupon_no VARCHAR2(105) NOT NULL, /* 쿠폰번호 */
	coupon_name VARCHAR2(60) NOT NULL, /* 쿠폰명 */
	coupon_benefit NUMBER(7,2) NOT NULL, /* 쿠폰 혜택 */
	coupon_avail_date NUMBER(2) NOT NULL, /* 사용가능 일수 */
	coupon_end_date DATE, /* 사용가능 종료일 */
	coupon_min_purchase NUMBER(9), /* 최소 구매금액 */
	coupon_payment VARCHAR2(18) NOT NULL, /* 결제수단 */
	brand_code CHAR(14) /* 업체코드 */
);
----  쿠폰 제약 조건 추가 ----
ALTER TABLE coupon
	ADD	CONSTRAINT PK_coupon PRIMARY KEY (coupon_no)
	ADD	CONSTRAINT CK_coupon_couponno
		CHECK (REGEXP_LIKE (coupon_no,'^[a-zA-Z0-9]{10,35}$'));

/* 회원보유쿠폰 */
CREATE TABLE m_coupon (
	coupon_no VARCHAR2(105) NOT NULL, /* 쿠폰번호 */
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	cp_start_date DATE NOT NULL, /* 쿠폰 사용 가능
시작일 */
	cp_end_date DATE NOT NULL /* 쿠폰 사용 가능
종료일 */
);
----  회원보유쿠폰 제약 조건 추가 ----
ALTER TABLE m_coupon
	ADD	CONSTRAINT PK_m_coupon PRIMARY KEY (coupon_no,member_no);

/* 배송지 */
CREATE TABLE shipping_addr (
	shipping_code NUMBER(6) NOT NULL, /* 배송지고유번호 */
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	name VARCHAR2(15) NOT NULL, /* 이름 */
	shipping_name VARCHAR2(30) NOT NULL, /* 배송지명 */
	zip_code VARCHAR2(20) NOT NULL, /* 우편번호 */
	address VARCHAR2(50) NOT NULL, /* 주소 */
	tel VARCHAR2(20), /* 일반전화 */
	phone VARCHAR2(20) NOT NULL, /* 핸드폰 */
	recently_date DATE, /* 최근배송일자 */
	default_shipping CHAR(1) DEFAULT 'N' NOT NULL, /* 기본배송지여부 */
	top_fix CHAR(1) DEFAULT 'N' NOT NULL /* 상단고정여부 */
);
----  배송지 제약 조건 추가 ----
ALTER TABLE shipping_addr
	ADD	CONSTRAINT PK_shipping_addr	PRIMARY KEY (shipping_code,member_no)
	ADD	CONSTRAINT CK_shippingaddr_default
		CHECK (default_shipping IN( 'Y', 'N'))
	ADD	CONSTRAINT CK_shippingaddr_topfix
		CHECK (top_fix IN( 'Y', 'N'));

/* 상품 */
CREATE TABLE product (
	product_code VARCHAR2(13) NOT NULL, /* 상품코드 */
	img_code NUMBER(8) NOT NULL, /* 상품이미지번호 */
	product_name VARCHAR2(200) NOT NULL, /* 상품명 */
	category_code CHAR(10) NOT NULL, /* 상품분류코드 */
	price NUMBER(8) NOT NULL, /* 판매가 */
	summary VARCHAR2(200), /* 상품요약정보 */
	grade NUMBER(1), /* 상품평점 */
	review_num NUMBER(5), /* 리뷰수 */
	stock NUMBER(10) DEFAULT 0 NOT NULL, /* 재고량 */
	howtodelivery VARCHAR2(50), /* 배송방식 */
	delivery_charge_code NUMBER(1) NOT NULL /* 배송비코드 */
);
----  상품 제약 조건 추가 ----
ALTER TABLE product
	ADD	CONSTRAINT PK_product PRIMARY KEY (product_code)
	ADD CONSTRAINT CK_product_grade	
        CHECK (REGEXP_LIKE (grade,'^[0-5]$'));

/* 주문상품 */
CREATE TABLE p_order (
	order_no CHAR(14) NOT NULL, /* 주문번호 */
	product_code VARCHAR2(13) NOT NULL, /* 상품코드 */
	count NUMBER(4) DEFAULT 1 NOT NULL /* 상품수량 */
);
----  주문상품 제약 조건 추가 ----
ALTER TABLE p_order
	ADD	CONSTRAINT PK_p_order PRIMARY KEY (order_no,product_code);

/* 주문처리상태 */
CREATE TABLE order_status (
	orderstatus_code NUMBER(1) NOT NULL, /* 주문처리상태코드 */
	order_status CHAR(15) NOT NULL /* 주문처리상태 */
);
----  주문처리상태 제약 조건 추가 ----
ALTER TABLE order_status
	ADD	CONSTRAINT PK_order_status PRIMARY KEY (orderstatus_code);

/* 주문 */
CREATE TABLE m_order (
	order_no CHAR(14) NOT NULL, /* 주문번호 */
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	orderstatus_code NUMBER(1) NOT NULL, /* 주문처리상태코드 */
	order_date DATE DEFAULT SYSDATE NOT NULL, /* 주문일자 */
	purchase_amount NUMBER(8) NOT NULL /* 상품구매금액 */
);
----  주문 제약 조건 추가 ----
ALTER TABLE m_order
	ADD	CONSTRAINT PK_m_order PRIMARY KEY (order_no);

/* 장바구니 */
CREATE TABLE basket (
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	product_code VARCHAR2(13) NOT NULL, /* 상품코드 */
	count NUMBER(4) DEFAULT 1 NOT NULL, /* 수량 */
	put_date DATE DEFAULT SYSDATE NOT NULL /* 장바구니에 담긴일자 */
);
----  장바구니 제약 조건 추가 ----
ALTER TABLE basket
	ADD	CONSTRAINT PK_basket PRIMARY KEY (member_no,product_code);

/* 관심상품 */
CREATE TABLE p_interest (
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	product_code VARCHAR2(13) NOT NULL /* 상품코드 */
);
----  관심상품 제약 조건 추가 ----
ALTER TABLE p_interest
	ADD	CONSTRAINT PK_p_interest PRIMARY KEY (member_no,product_code);

/* 리뷰 */
CREATE TABLE review (
	review_no NUMBER NOT NULL, /* 리뷰번호 */
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	product_code VARCHAR2(13) NOT NULL, /* 상품코드 */
	ratings NUMBER(2,1) NOT NULL, /* 리뷰평점 */
	review_contents VARCHAR2(600) NOT NULL, /* 리뷰내용 */
	r_regdate DATE DEFAULT SYSDATE NOT NULL, /* 작성일자 */
	like_count NUMBER, /* 추천수 */
	dislike_count NUMBER /* 비추천수 */
);
----  리뷰 제약 조건 추가 ----
ALTER TABLE review
	ADD	CONSTRAINT PK_review PRIMARY KEY (review_no)
	ADD	CONSTRAINT CK_review_ratings
		CHECK (REGEXP_LIKE (ratings,'^[0-5]$'));

/* 업체-상품 등록 */
CREATE TABLE p_brand (
	brand_code CHAR(14) NOT NULL, /* 업체코드 */
	product_code VARCHAR2(13) NOT NULL, /* 상품코드 */
	regist_date DATE DEFAULT SYSDATE NOT NULL /* 등록일 */
);
----  업체-상품 등록 제약 조건 추가 ----
ALTER TABLE p_brand
	ADD	CONSTRAINT PK_p_brand PRIMARY KEY (brand_code,product_code);

/* 업체 */
CREATE TABLE brand (
	brand_code CHAR(14) NOT NULL, /* 업체코드 */
	brand_name VARCHAR2(30) NOT NULL /* 업체명 */
);
----  업체 제약 조건 추가 ----
ALTER TABLE brand
	ADD	CONSTRAINT PK_brand	PRIMARY KEY (brand_code);

/* 상품분류 */
CREATE TABLE p_category (
	category_code CHAR(10) NOT NULL, /* 상품분류코드 */
	category VARCHAR2(30) NOT NULL, /* 대분류 */
	sub_category VARCHAR2(30) NOT NULL /* 소분류 */
);
----  상품분류 제약 조건 추가 ----
ALTER TABLE p_category
	ADD	CONSTRAINT PK_p_category PRIMARY KEY (category_code);

/* 상품이미지 */
CREATE TABLE image (
	img_code NUMBER(8) NOT NULL, /* 상품이미지번호 */
	uploadPath VARCHAR2(100), /* 파일경로 */
	fileName VARCHAR2(100) NOT NULL /* 파일명 */
);
----  상품이미지 제약 조건 추가 ----
ALTER TABLE image
	ADD	CONSTRAINT PK_image	PRIMARY KEY (img_code)
	ADD	CONSTRAINT CK_image_fileName
        CHECK (REGEXP_LIKE (fileName,'.*\.(jpg|jpeg|jpe|png)$'));

/* 할인 */
CREATE TABLE discount (
	product_code VARCHAR2(13) NOT NULL, /* 상품코드 */
	start_discount DATE, /* 할인시작일 */
	end_discount DATE, /* 할인종료일 */
	discount_rate NUMBER(3) /* 할인율 */
);
----  할인 제약 조건 추가 ----
ALTER TABLE discount
	ADD	CONSTRAINT PK_discount PRIMARY KEY (product_code)
	ADD	CONSTRAINT CK_discount_rate
		CHECK (REGEXP_LIKE (discount_rate,'(100|[1-9]?[0-9])'));

/* 배송비 */
CREATE TABLE delivery_charge (
	delivery_charge_code NUMBER(1) NOT NULL, /* 배송비코드 */
	basic_charge NUMBER(4) NOT NULL, /* 기본배송비 */
	free_condition NUMBER(6) /* 배송비무료조건 */
);
----  배송비 제약 조건 추가 ----
ALTER TABLE delivery_charge
	ADD	CONSTRAINT PK_delivery_charge PRIMARY KEY (delivery_charge_code);

/* 리뷰추천 */
CREATE TABLE r_recommand (
	member_no CHAR(14) NOT NULL, /* 회원번호 */
	review_no NUMBER NOT NULL, /* 리뷰번호 */
	recco_status CHAR(1 CHAR) NOT NULL /* 추천여부 */
);
----  리뷰추천 제약 조건 추가 ----
ALTER TABLE r_recommand
	ADD	CONSTRAINT PK_r_recommand PRIMARY KEY (member_no,review_no)
	ADD	CONSTRAINT CK_r_recommand_recco_status
		CHECK (recco_status IN ('Y','N'));

----  각 테이블의 외래키 추가 ----
ALTER TABLE memberinfo
	ADD
		CONSTRAINT FK_membership_TO_memberinfo
		FOREIGN KEY (grade_name)
		REFERENCES membership (grade_name);

ALTER TABLE savedmoney
	ADD
		CONSTRAINT FK_memberinfo_TO_savedmoney
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE membership
	ADD
		CONSTRAINT FK_coupon_TO_membership
		FOREIGN KEY (
			coupon_no
		)
		REFERENCES coupon (
			coupon_no
		);

ALTER TABLE coupon
	ADD
		CONSTRAINT FK_brand_TO_coupon
		FOREIGN KEY (
			brand_code
		)
		REFERENCES brand (
			brand_code
		);

ALTER TABLE m_coupon
	ADD
		CONSTRAINT FK_coupon_TO_m_coupon
		FOREIGN KEY (
			coupon_no
		)
		REFERENCES coupon (
			coupon_no
		);

ALTER TABLE m_coupon
	ADD
		CONSTRAINT FK_memberinfo_TO_m_coupon
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE shipping_addr
	ADD
		CONSTRAINT FK_memberinfo_TO_shipping_addr
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE product
	ADD
		CONSTRAINT FK_p_category_TO_product
		FOREIGN KEY (
			category_code
		)
		REFERENCES p_category (
			category_code
		);

ALTER TABLE product
	ADD
		CONSTRAINT FK_image_TO_product
		FOREIGN KEY (
			img_code
		)
		REFERENCES image (
			img_code
		);

ALTER TABLE product
	ADD
		CONSTRAINT FK_delivery_charge_TO_product
		FOREIGN KEY (
			delivery_charge_code
		)
		REFERENCES delivery_charge (
			delivery_charge_code
		);

ALTER TABLE p_order
	ADD
		CONSTRAINT FK_m_order_TO_p_order
		FOREIGN KEY (
			order_no
		)
		REFERENCES m_order (
			order_no
		);

ALTER TABLE p_order
	ADD
		CONSTRAINT FK_product_TO_p_order
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE m_order
	ADD
		CONSTRAINT FK_memberinfo_TO_m_order
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE m_order
	ADD
		CONSTRAINT FK_order_status_TO_m_order
		FOREIGN KEY (
			orderstatus_code
		)
		REFERENCES order_status (
			orderstatus_code
		);

ALTER TABLE basket
	ADD
		CONSTRAINT FK_memberinfo_TO_basket
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE basket
	ADD
		CONSTRAINT FK_product_TO_basket
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE p_interest
	ADD
		CONSTRAINT FK_product_TO_p_interest
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE p_interest
	ADD
		CONSTRAINT FK_memberinfo_TO_p_interest
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE review
	ADD
		CONSTRAINT FK_memberinfo_TO_review
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE review
	ADD
		CONSTRAINT FK_product_TO_review
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE p_brand
	ADD
		CONSTRAINT FK_product_TO_p_brand
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE p_brand
	ADD
		CONSTRAINT FK_brand_TO_p_brand
		FOREIGN KEY (
			brand_code
		)
		REFERENCES brand (
			brand_code
		);

ALTER TABLE discount
	ADD
		CONSTRAINT FK_product_TO_discount
		FOREIGN KEY (
			product_code
		)
		REFERENCES product (
			product_code
		);

ALTER TABLE r_recommand
	ADD
		CONSTRAINT FK_memberinfo_TO_r_recommand
		FOREIGN KEY (
			member_no
		)
		REFERENCES memberinfo (
			member_no
		);

ALTER TABLE r_recommand
	ADD
		CONSTRAINT FK_review_TO_r_recommand
		FOREIGN KEY (
			review_no
		)
		REFERENCES review (
			review_no
		);