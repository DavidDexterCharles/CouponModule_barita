


DROP TABLE IF EXISTS status_codes;

CREATE TABLE status_codes (
  status_id int NOT NULL IDENTITY(1,1),
  status_name varchar(50) NOT NULL,
  PRIMARY KEY (status_id)
);





INSERT INTO status_codes VALUES ('PENDING');

INSERT INTO status_codes VALUES ('ACTIVE');

INSERT INTO status_codes VALUES ('CANCELLED');




DROP TABLE IF EXISTS securities;

CREATE TABLE securities (
  isin_code varchar(20) NOT NULL,
  description varchar(max) NOT NULL,
  status_id int DEFAULT NULL,
  PRIMARY KEY (isin_code)
);





INSERT INTO securities VALUES ('GUB00616B243', 'Fixed Rate 7.25% USD Benchmark Notes 2016','5');

INSERT INTO securities VALUES ('US470160AR34', 'Governmennt of Jamaica 10.625% notes due 2017','5');

INSERT INTO securities VALUES ('US470160AS17', 'Government of Jamaica 9.0% notes due 2015','5');

INSERT INTO securities VALUES ('US470160AT99', 'Government of Jamaica 9.25% notes due 2025','5');

INSERT INTO securities VALUES ('US470160AQ50', 'Government of Jamaica 11.625% notes due 2022','5');

INSERT INTO securities VALUES ('USP7807HAP03', 'PETROLEOS DE VENEZUELA SA (Regulation S) Due 11/17/2021 @ 9% S&P CCC+  ','5');

INSERT INTO securities VALUES ('USP71647NAF69', 'PETROBRAS GLOBAL FINANCE 4.375% due 2023','5');

INSERT INTO securities VALUES ('USP17625AD98', 'REPUBLIC OF VENEZUELA REG-S, DUE 2031','5');

INSERT INTO securities VALUES ('US716558AC52', 'PETROLEOS DE VENEZUELA S 12.75% (144A) DUE 2022','5');

INSERT INTO securities VALUES ('JMB201400034', 'Bank of Jamaica $US Certificate of Deposit 20181217','5');

INSERT INTO securities VALUES ('JMB201400158', 'Bank of Jamaica $US Certificate of Deposit 20191217','5');

INSERT INTO securities VALUES ('JMB201400166', 'Bank of Jamaica $US Certificate of Deposit 20211217','5');

INSERT INTO securities VALUES ('GOJ TBILL (2015)', 'GOVERNMENT OF JAMAICA TREASURY BILL 20150119','5');

INSERT INTO securities VALUES ('GOJ TBILL -2015', 'GOVERNMENT OF JAMAICA TREASURY BILL 20150320','5');

INSERT INTO securities VALUES ('GOJ TBILL2015', 'GOVERNMENT OF JAMAICA TREASURY BILL 20150619','5');

INSERT INTO securities VALUES ('USP7807HAM71', 'PETROLEOS DE VENEZUELA S 12.75% (Regulation S) DUE 2022','5');

INSERT INTO securities VALUES ('GBF01122D287', 'FR 8.75% BMI Notes 2022','5');

INSERT INTO securities VALUES ('US470160BE12', 'Government of Jamaica 8.425% (Regulation S) notes due 2017','5');

INSERT INTO securities VALUES ('US470160BD39', 'Government of Jamaica 8.425% (144A) notes due 2017','5');

INSERT INTO securities VALUES ('US470160BF86', 'Government of Jamaica 12.625% (144A)notes due 2016','5');

INSERT INTO securities VALUES ('US470160BG69', 'Government of Jamaica 12.625% (Regulation S) notes due 2016','5');

INSERT INTO securities VALUES ('US470160BC55', 'Government of Jamaica 8.55% (regulation S) notes due 2020','5');

INSERT INTO securities VALUES ('US470160BB72', 'Government of Jamaica 8.55% ( 144A) notes due 2020','5');

INSERT INTO securities VALUES ('GBF00315B241', 'Fixed Rate 7.20% Benchmark Investment Notes 2015','5');

INSERT INTO securities VALUES ('US470160BP68', 'Government of Jamaica 8.5% notes due 2021','5');

INSERT INTO securities VALUES ('BJV00216M195', 'Bank of Jamaica variable Rate Certificate of Deposit 20161219','5');

INSERT INTO securities VALUES ('BJV36415M183', 'Bank of Jamaica variable Rate Certificate of Deposit 20151218','5');

INSERT INTO securities VALUES ('US896292AF68', 'Rep of Trinidad & Tobago USD FGN BD (144A) 9.7500% DUE 07/01/2020','5');

INSERT INTO securities VALUES ('USP93960AA38', 'Rep of Trinidad & Tobago USD FGN BD (Regulation S) 9.7500% DUE 07/01/2020','5');

INSERT INTO securities VALUES ('GOJ TBILL 2015Z', 'GOVERNMENT OF JAMAICA TREASURY BILL 20150220','5');

INSERT INTO securities VALUES ('GOJ TBILL 2015Y', 'GOVERNMENT OF JAMAICA TREASURY BILL 20150522','5');

INSERT INTO securities VALUES ('USG6149AAA72', 'Mirant JPSCO Finance Ltd. (Funding Corp), Regulation S,Senior Notes Due 2016','5');

INSERT INTO securities VALUES ('US60468AAA43', 'Mirant JPSCO Finance Ltd. (Funding Corp), 144A, Senior Notes Due 2016','5');

INSERT INTO securities VALUES ('JMB201500015', 'Bank of Jamaica $US Certificate of Deposit 20220110','5');

INSERT INTO securities VALUES ('TREASURY BILL', 'GOJ TBILL','5');

INSERT INTO securities VALUES ('BOJ REPO', 'BOJ REPO','5');

INSERT INTO securities VALUES ('BJV36416A087', 'Bank of Jamaica Variable Rate Certificate of Deposit 20160108','5');

INSERT INTO securities VALUES ('JMB201500106', 'Bank of Jamaica $US Certificate of Deposit 20190119','5');

INSERT INTO securities VALUES ('JMB201500205', 'Bank of Jamaica $US Certificate of Deposit 20200109','5');

INSERT INTO securities VALUES ('BJU36516B034', '3.25% US-INDEXED NOTE 2016','5');

INSERT INTO securities VALUES ('BJU36416B094', '3.25% US-INDEXED NOTE 2016A','5');

INSERT INTO securities VALUES ('JMB201500114', 'Bank of Jamaica $US Certificate of Deposit 20220210','5');

INSERT INTO securities VALUES ('JMB201500221', 'Bank of Jamaica $US Certificate of Deposit 20200210','5');

INSERT INTO securities VALUES ('JMB201500023', 'Bank of Jamaica $US Certificate of Deposit 20221002','5');

INSERT INTO securities VALUES ('BJV36516B264', 'Bank of Jamaica Variable Rate Certificate of Deposit 20200216','5');

INSERT INTO securities VALUES ('BJV00217B246', 'Bank of Jamaica Variable Rate Certificate of Deposit ','5');

INSERT INTO securities VALUES ('BJU00318B268', 'Bank of Jamaica Variable Rate Certificate of Deposit 20180226','5');

INSERT INTO securities VALUES ('JMB201500049', 'BOJ USD COD_5 YEARS_20150227','5');

INSERT INTO securities VALUES ('JMB201500031', 'BOJ USD COD_7 YEARS_20150227','5');

INSERT INTO securities VALUES ('BJV36616B114', 'Bank of Jamaica variable Rate Certificate of Deposit 20160211','5');

INSERT INTO securities VALUES ('BJV00217B097', 'Bank of Jamaica variable Rate Certificate of Deposit 20170209','5');



DROP TABLE IF EXISTS coupons;

CREATE TABLE coupons (
  coupon_id int NOT NULL IDENTITY(1,1),
  isin_code varchar(20) DEFAULT NULL,
  payment_date datetime2(0) DEFAULT NULL,
  record_date datetime2(0) DEFAULT NULL,
  status_id int DEFAULT NULL,
  PRIMARY KEY (coupon_id)
);
