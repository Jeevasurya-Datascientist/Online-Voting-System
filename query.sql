CREATE DATABASE online_voting_system;
USE online_voting_system;

CREATE TABLE candidates (
    id INT(25) NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    place VARCHAR(100) NOT NULL,
    politic_name VARCHAR(100) DEFAULT NULL,
    image_path VARCHAR(500) DEFAULT NULL
);

INSERT INTO candidates (id, name, place, politic_name, image_path) VALUES
(11, 'Alex Johnson', 'Madurai', 'Unity Alliance', '/uploads/ntk.jpg'),
(12, 'Sophia Roberts', 'Erode', 'Peoples Choice', '/uploads/tvk.jpg'),
(13, 'Ethan Thompson', 'Coimbatore', 'Freedom Union', '/uploads/BJP.jpg'),
(14, 'James Wilson', 'Thousand Lights', 'Future Vision', '/uploads/dmk.jpg'),
(15, 'David Wilson', 'Theni', 'Community First', '/uploads/AIADMK.png');

CREATE TABLE voters (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) DEFAULT NULL,
    voter_id VARCHAR(20) DEFAULT NULL,
    dob DATE DEFAULT NULL,
    phone VARCHAR(15) DEFAULT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE votes (
    vote_id INT(5) AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT(2) NOT NULL,
    voter_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    voter_id_string VARCHAR(60) NOT NULL
);

ALTER TABLE voters
ADD COLUMN has_voted TINYINT(1) NOT NULL DEFAULT 0;


INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1, 'User 1', 'UCC6253945', '1962-10-13', '5558168985', 'user1@example.com'),
(2, 'User 2', 'WIH1492499', '1966-12-19', '6787542495', 'user2@example.com'),
(3, 'User 3', 'BRL1672532', '1955-02-27', '8177391620', 'user3@example.com'),
(4, 'User 4', 'AOQ9042734', '1920-09-18', '5620469631', 'user4@example.com'),
(5, 'User 5', 'JPG6353555', '1994-12-19', '7365884206', 'user5@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(6, 'User 6', 'ZQJ9669386', '2000-10-05', '9237455912', 'user6@example.com'),
(7, 'User 7', 'WVB8222342', '1941-11-17', '8297050738', 'user7@example.com'),
(8, 'User 8', 'REL2084901', '1948-04-18', '5934849095', 'user8@example.com'),
(9, 'User 9', 'DBH9323564', '1948-09-18', '8405332622', 'user9@example.com'),
(10, 'User 10', 'HVM0573525', '1997-10-27', '7715505157', 'user10@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(11, 'User 11', 'EMY8010555', '1904-02-13', '0273136765', 'user11@example.com'),
(12, 'User 12', 'FJC6984020', '1982-09-23', '6363045357', 'user12@example.com'),
(13, 'User 13', 'RFH0587030', '1963-06-23', '0799828807', 'user13@example.com'),
(14, 'User 14', 'QIF9048500', '1995-07-29', '3047720435', 'user14@example.com'),
(15, 'User 15', 'NHD2536299', '1912-09-07', '0990608464', 'user15@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(16, 'User 16', 'IVK1205165', '1940-12-30', '4578091829', 'user16@example.com'),
(17, 'User 17', 'SVJ8114753', '1991-11-11', '4519666906', 'user17@example.com'),
(18, 'User 18', 'PBE9144506', '1936-02-15', '7556211193', 'user18@example.com'),
(19, 'User 19', 'GRT0582693', '1900-07-07', '7741247272', 'user19@example.com'),
(20, 'User 20', 'OQP4818679', '1983-09-01', '4163004924', 'user20@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(21, 'User 21', 'ZFU4301302', '1908-01-26', '4295854090', 'user21@example.com'),
(22, 'User 22', 'CKY9296534', '1975-02-25', '2184550062', 'user22@example.com'),
(23, 'User 23', 'ESJ3168716', '1943-06-10', '9006243694', 'user23@example.com'),
(24, 'User 24', 'BYI3886703', '1990-09-20', '6701912865', 'user24@example.com'),
(25, 'User 25', 'IPA7304121', '1915-04-22', '1315384475', 'user25@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(26, 'User 26', 'VDZ6284968', '1956-09-08', '8544495638', 'user26@example.com'),
(27, 'User 27', 'HYP0253894', '1979-02-04', '0410260575', 'user27@example.com'),
(28, 'User 28', 'SZQ5591790', '2004-03-06', '8060736404', 'user28@example.com'),
(29, 'User 29', 'PBT1157129', '1942-10-05', '2545726396', 'user29@example.com'),
(30, 'User 30', 'IAV3888680', '1939-01-23', '7711771206', 'user30@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(31, 'User 31', 'WFN0763771', '1953-10-05', '6483745203', 'user31@example.com'),
(32, 'User 32', 'CAB5787079', '1940-11-18', '7712354761', 'user32@example.com'),
(33, 'User 33', 'RJD9785012', '1936-12-23', '4934078214', 'user33@example.com'),
(34, 'User 34', 'SZY4450276', '1934-06-19', '3537161257', 'user34@example.com'),
(35, 'User 35', 'KEO4439037', '1918-04-24', '7176757345', 'user35@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(36, 'User 36', 'EQC2156047', '1925-06-28', '6207914039', 'user36@example.com'),
(37, 'User 37', 'NDS8927173', '1905-09-13', '3272282856', 'user37@example.com'),
(38, 'User 38', 'LCS3088993', '1961-08-19', '2707261828', 'user38@example.com'),
(39, 'User 39', 'RDQ0221495', '1926-10-16', '8963974060', 'user39@example.com'),
(40, 'User 40', 'BAU5792248', '1997-04-12', '8922277668', 'user40@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(41, 'User 41', 'WSJ5885515', '1911-08-14', '5060584188', 'user41@example.com'),
(42, 'User 42', 'XNO1886808', '1931-04-16', '5049485065', 'user42@example.com'),
(43, 'User 43', 'YKF4996195', '1948-07-11', '5515182086', 'user43@example.com'),
(44, 'User 44', 'VFN2367250', '1995-10-05', '7016550332', 'user44@example.com'),
(45, 'User 45', 'LSR3664329', '1902-02-11', '8806751586', 'user45@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(46, 'User 46', 'CTW6791454', '1925-12-04', '4863403598', 'user46@example.com'),
(47, 'User 47', 'OZO8989801', '1957-06-03', '7507668980', 'user47@example.com'),
(48, 'User 48', 'KVU2696376', '1914-12-24', '1771960930', 'user48@example.com'),
(49, 'User 49', 'GJP5253207', '1980-10-23', '2612217969', 'user49@example.com'),
(50, 'User 50', 'PXQ3469864', '1942-11-19', '0336936783', 'user50@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(51, 'User 51', 'JTV5538124', '1973-02-08', '2581595588', 'user51@example.com'),
(52, 'User 52', 'ICS8949829', '1984-06-05', '6200288738', 'user52@example.com'),
(53, 'User 53', 'KQV5348020', '2003-01-03', '1490978161', 'user53@example.com'),
(54, 'User 54', 'TEW5285939', '2003-03-12', '4409371211', 'user54@example.com'),
(55, 'User 55', 'VUQ7504292', '1911-01-28', '0783897008', 'user55@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(56, 'User 56', 'XGY1134543', '1989-10-11', '9049985886', 'user56@example.com'),
(57, 'User 57', 'SCR3511881', '1914-10-01', '2105429372', 'user57@example.com'),
(58, 'User 58', 'CPJ9856194', '1960-12-04', '6199049327', 'user58@example.com'),
(59, 'User 59', 'GLF0874679', '1929-05-04', '7312912346', 'user59@example.com'),
(60, 'User 60', 'MJC2932940', '1930-09-24', '4488430806', 'user60@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(61, 'User 61', 'HQI9416454', '1952-05-28', '6036548104', 'user61@example.com'),
(62, 'User 62', 'ORT1209521', '1924-09-01', '5580662696', 'user62@example.com'),
(63, 'User 63', 'FUK8882133', '1957-12-08', '7403202551', 'user63@example.com'),
(64, 'User 64', 'AHT9485255', '1934-02-14', '8621700052', 'user64@example.com'),
(65, 'User 65', 'BRD9261321', '1979-02-17', '8825179535', 'user65@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(66, 'User 66', 'XAY3459504', '1986-07-15', '2048130488', 'user66@example.com'),
(67, 'User 67', 'DYT2775438', '1950-04-17', '1223891843', 'user67@example.com'),
(68, 'User 68', 'WCE5222829', '1982-03-29', '7276679814', 'user68@example.com'),
(69, 'User 69', 'VFV8059388', '1959-08-26', '8162561578', 'user69@example.com'),
(70, 'User 70', 'PDU0968839', '1939-03-05', '6646011670', 'user70@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(71, 'User 71', 'QGB6919911', '1938-02-10', '7735112214', 'user71@example.com'),
(72, 'User 72', 'LDN6327767', '1982-06-14', '9409934954', 'user72@example.com'),
(73, 'User 73', 'ERM1799761', '1906-04-19', '7623935994', 'user73@example.com'),
(74, 'User 74', 'CYV5645458', '1988-01-10', '5074408808', 'user74@example.com'),
(75, 'User 75', 'AKZ7144445', '2005-07-24', '5087702550', 'user75@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(76, 'User 76', 'KSF7908208', '1970-05-16', '2796459788', 'user76@example.com'),
(77, 'User 77', 'XKA5286586', '1981-03-08', '7485941876', 'user77@example.com'),
(78, 'User 78', 'NCS8034239', '1987-01-29', '1253886167', 'user78@example.com'),
(79, 'User 79', 'PGO5023559', '1915-04-25', '6205666048', 'user79@example.com'),
(80, 'User 80', 'CCB3340648', '1911-10-20', '3574405968', 'user80@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(81, 'User 81', 'EVE9608983', '1963-10-18', '8064247892', 'user81@example.com'),
(82, 'User 82', 'WEI7231597', '1981-11-22', '9732727865', 'user82@example.com'),
(83, 'User 83', 'NTC9935896', '1991-09-12', '1468083262', 'user83@example.com'),
(84, 'User 84', 'VMJ0603089', '1973-09-18', '3090566095', 'user84@example.com'),
(85, 'User 85', 'MVH9731565', '1956-05-01', '2599889094', 'user85@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(86, 'User 86', 'ILK2155083', '1965-02-10', '4229120331', 'user86@example.com'),
(87, 'User 87', 'NYX0887674', '1909-06-25', '3843715222', 'user87@example.com'),
(88, 'User 88', 'BZQ1508575', '1926-11-01', '8646563741', 'user88@example.com'),
(89, 'User 89', 'EQE1596065', '1998-11-29', '1451750599', 'user89@example.com'),
(90, 'User 90', 'CRS5074494', '1999-11-01', '9564586911', 'user90@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(91, 'User 91', 'DKL8408874', '1951-12-28', '2073289972', 'user91@example.com'),
(92, 'User 92', 'KTS1534789', '1904-02-11', '3140064764', 'user92@example.com'),
(93, 'User 93', 'FQH1913888', '1998-04-10', '6700874773', 'user93@example.com'),
(94, 'User 94', 'SXH4888514', '1931-01-09', '1140564597', 'user94@example.com'),
(95, 'User 95', 'DWK4856205', '1908-10-12', '5124772297', 'user95@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(96, 'User 96', 'YUS3036764', '1913-03-03', '4249680388', 'user96@example.com'),
(97, 'User 97', 'AGG7464068', '1923-06-19', '5508288102', 'user97@example.com'),
(98, 'User 98', 'SSC4418684', '1951-05-21', '4618192203', 'user98@example.com'),
(99, 'User 99', 'HGK5538774', '1901-05-08', '3247053809', 'user99@example.com'),
(100, 'User 100', 'OBU1725496', '1912-11-30', '5753111931', 'user100@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(101, 'User 101', 'QUG4113040', '1954-08-13', '9021432535', 'user101@example.com'),
(102, 'User 102', 'QOT5966768', '1934-04-24', '5477273474', 'user102@example.com'),
(103, 'User 103', 'GSJ3177435', '1967-03-25', '0538767895', 'user103@example.com'),
(104, 'User 104', 'ZVK7439179', '1955-09-25', '6248245797', 'user104@example.com'),
(105, 'User 105', 'TVY9784558', '1950-06-22', '3117549788', 'user105@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(106, 'User 106', 'RDB7875052', '1905-11-03', '1524237625', 'user106@example.com'),
(107, 'User 107', 'ZJT1283333', '1972-11-21', '2506747136', 'user107@example.com'),
(108, 'User 108', 'KBH3761814', '1920-11-03', '5525999141', 'user108@example.com'),
(109, 'User 109', 'KIG0920421', '1963-11-14', '6347744337', 'user109@example.com'),
(110, 'User 110', 'PXO8578754', '1927-05-13', '6195399554', 'user110@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(111, 'User 111', 'GNQ4439923', '1934-02-22', '3004878941', 'user111@example.com'),
(112, 'User 112', 'IVG3139120', '1987-07-06', '8598313466', 'user112@example.com'),
(113, 'User 113', 'MNQ3606026', '1957-11-29', '1737600963', 'user113@example.com'),
(114, 'User 114', 'OKR0116305', '1968-08-19', '8383634247', 'user114@example.com'),
(115, 'User 115', 'XCM2406688', '1961-05-04', '7657461908', 'user115@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(116, 'User 116', 'FIO4583891', '1985-09-01', '3210840395', 'user116@example.com'),
(117, 'User 117', 'JZO6379384', '1933-02-12', '9888355854', 'user117@example.com'),
(118, 'User 118', 'CPV8499724', '1994-07-24', '9947653194', 'user118@example.com'),
(119, 'User 119', 'NOR5594471', '1949-01-11', '8253599978', 'user119@example.com'),
(120, 'User 120', 'TUV6087032', '1906-07-23', '7137199063', 'user120@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(121, 'User 121', 'TEZ4632055', '1962-01-29', '3068889866', 'user121@example.com'),
(122, 'User 122', 'TEF3063145', '1991-06-08', '9909774795', 'user122@example.com'),
(123, 'User 123', 'LUJ4818464', '1978-07-01', '0680278435', 'user123@example.com'),
(124, 'User 124', 'HDU5704416', '1910-09-23', '2414884135', 'user124@example.com'),
(125, 'User 125', 'AOS8720498', '1993-11-08', '4161254339', 'user125@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(126, 'User 126', 'XXG5382536', '1917-08-17', '2083343751', 'user126@example.com'),
(127, 'User 127', 'INT1647514', '1929-03-09', '1427880476', 'user127@example.com'),
(128, 'User 128', 'KIM3452105', '1973-11-08', '5304693435', 'user128@example.com'),
(129, 'User 129', 'ATV5826554', '1984-07-20', '3692455486', 'user129@example.com'),
(130, 'User 130', 'FMC5031143', '1982-04-05', '1815160436', 'user130@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(131, 'User 131', 'PEU6431307', '1985-01-18', '7911497994', 'user131@example.com'),
(132, 'User 132', 'UEB6844848', '1930-04-28', '6475819735', 'user132@example.com'),
(133, 'User 133', 'RNL0415404', '2000-08-28', '4847413165', 'user133@example.com'),
(134, 'User 134', 'HPM0806980', '1943-11-16', '4636274726', 'user134@example.com'),
(135, 'User 135', 'ZXX1655442', '1909-06-12', '0734316661', 'user135@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(136, 'User 136', 'BWA6577070', '1928-05-11', '8095211456', 'user136@example.com'),
(137, 'User 137', 'OSW0810817', '1903-10-09', '8234271921', 'user137@example.com'),
(138, 'User 138', 'BNR6877351', '1903-01-13', '1421303709', 'user138@example.com'),
(139, 'User 139', 'WWY7393589', '1986-01-12', '4625127240', 'user139@example.com'),
(140, 'User 140', 'IJU3037278', '1933-06-13', '5825763410', 'user140@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(141, 'User 141', 'ZFH1191600', '1977-09-12', '1322004610', 'user141@example.com'),
(142, 'User 142', 'PJJ3259899', '1915-11-25', '0393366088', 'user142@example.com'),
(143, 'User 143', 'TDR7587563', '1909-08-01', '4807322398', 'user143@example.com'),
(144, 'User 144', 'TPN2000198', '1948-02-06', '4120798392', 'user144@example.com'),
(145, 'User 145', 'SGV2365464', '1941-10-23', '0254969173', 'user145@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(146, 'User 146', 'SRP1665142', '2005-06-06', '5890938490', 'user146@example.com'),
(147, 'User 147', 'DOG8179642', '1927-01-17', '8584302233', 'user147@example.com'),
(148, 'User 148', 'MFQ6155918', '1932-09-23', '6328178959', 'user148@example.com'),
(149, 'User 149', 'QNO0580443', '1910-05-15', '8998521930', 'user149@example.com'),
(150, 'User 150', 'DOL5008726', '1924-02-22', '5816028032', 'user150@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(151, 'User 151', 'ZAY5568580', '1941-03-29', '8592570900', 'user151@example.com'),
(152, 'User 152', 'OKM8950908', '1957-09-24', '3505998358', 'user152@example.com'),
(153, 'User 153', 'UNT7962627', '1992-02-17', '8717986585', 'user153@example.com'),
(154, 'User 154', 'LQK3012307', '1973-01-01', '4996091064', 'user154@example.com'),
(155, 'User 155', 'WED6181930', '1985-02-14', '4350037227', 'user155@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(156, 'User 156', 'VLR1752426', '1946-05-14', '1806264957', 'user156@example.com'),
(157, 'User 157', 'SNO9690908', '1903-03-13', '4037332993', 'user157@example.com'),
(158, 'User 158', 'SXW5313727', '1981-07-27', '7193282529', 'user158@example.com'),
(159, 'User 159', 'NJK4456931', '2002-02-21', '7137403572', 'user159@example.com'),
(160, 'User 160', 'MFP1682011', '2002-12-13', '1420750411', 'user160@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(161, 'User 161', 'PZY3157935', '1902-05-29', '5324698038', 'user161@example.com'),
(162, 'User 162', 'DCR1925243', '1946-01-07', '6136516582', 'user162@example.com'),
(163, 'User 163', 'ARL9713857', '1994-11-11', '0128522788', 'user163@example.com'),
(164, 'User 164', 'NLW8431679', '1977-06-12', '9311985146', 'user164@example.com'),
(165, 'User 165', 'CGY3379890', '1988-02-06', '6519427333', 'user165@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(166, 'User 166', 'UDT7828559', '1963-11-02', '2657953194', 'user166@example.com'),
(167, 'User 167', 'UTY7164858', '1920-02-16', '7186376458', 'user167@example.com'),
(168, 'User 168', 'CFK1458636', '1981-02-19', '9635010100', 'user168@example.com'),
(169, 'User 169', 'GPM7695186', '1948-11-29', '0779229616', 'user169@example.com'),
(170, 'User 170', 'XRS3617279', '1942-04-15', '3132055042', 'user170@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(171, 'User 171', 'KKK6055297', '1952-02-20', '1545854432', 'user171@example.com'),
(172, 'User 172', 'IAD5597641', '2003-06-07', '5289725105', 'user172@example.com'),
(173, 'User 173', 'CBD0925874', '1940-03-30', '1045847892', 'user173@example.com'),
(174, 'User 174', 'BSQ9514461', '1964-10-23', '6515446917', 'user174@example.com'),
(175, 'User 175', 'RGW4106849', '1903-09-18', '1997812738', 'user175@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(176, 'User 176', 'KPO2559897', '1922-03-15', '0056800643', 'user176@example.com'),
(177, 'User 177', 'QLX8207433', '2001-12-23', '0201286033', 'user177@example.com'),
(178, 'User 178', 'TOO7415621', '1953-07-02', '9967807847', 'user178@example.com'),
(179, 'User 179', 'UZC4211533', '1997-04-07', '5069038478', 'user179@example.com'),
(180, 'User 180', 'EXT4363347', '1986-09-13', '5660638589', 'user180@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(181, 'User 181', 'GJK9267067', '1907-04-19', '7868054581', 'user181@example.com'),
(182, 'User 182', 'QPW0312920', '1932-08-29', '0823257056', 'user182@example.com'),
(183, 'User 183', 'MKD3795700', '1939-03-13', '5892731336', 'user183@example.com'),
(184, 'User 184', 'LKT8070816', '1964-04-16', '2845496346', 'user184@example.com'),
(185, 'User 185', 'GSS8225128', '1925-01-12', '0713502248', 'user185@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(186, 'User 186', 'GJZ6820292', '2004-05-06', '9693861218', 'user186@example.com'),
(187, 'User 187', 'ODS8618884', '1982-07-15', '9323515026', 'user187@example.com'),
(188, 'User 188', 'KUH2559619', '1902-05-24', '6888036690', 'user188@example.com'),
(189, 'User 189', 'TML0799556', '1970-09-04', '5898397123', 'user189@example.com'),
(190, 'User 190', 'CTM9155855', '1959-01-03', '3498655699', 'user190@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(191, 'User 191', 'VMK3728546', '1914-03-28', '9399197577', 'user191@example.com'),
(192, 'User 192', 'DIW4283810', '1978-02-21', '9620454964', 'user192@example.com'),
(193, 'User 193', 'YCA1138560', '1961-11-10', '4262202413', 'user193@example.com'),
(194, 'User 194', 'TUM7249330', '1919-04-06', '6312023887', 'user194@example.com'),
(195, 'User 195', 'YGI8243916', '1903-09-03', '9816124256', 'user195@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(196, 'User 196', 'HZL6497767', '1925-06-09', '6315741323', 'user196@example.com'),
(197, 'User 197', 'JAF6516347', '1908-03-10', '3111701336', 'user197@example.com'),
(198, 'User 198', 'HGW1553086', '1977-12-19', '4706648396', 'user198@example.com'),
(199, 'User 199', 'JQT9851713', '1969-12-23', '5154037476', 'user199@example.com'),
(200, 'User 200', 'HOQ4169910', '1991-11-05', '0776914837', 'user200@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(201, 'User 201', 'KLY3053923', '1906-11-13', '0125463355', 'user201@example.com'),
(202, 'User 202', 'EXT3138649', '1927-01-02', '9777296696', 'user202@example.com'),
(203, 'User 203', 'CSJ4625507', '1995-03-14', '8411457223', 'user203@example.com'),
(204, 'User 204', 'BTU9455997', '1964-01-17', '9758419721', 'user204@example.com'),
(205, 'User 205', 'BZQ2860509', '1968-05-02', '5330191881', 'user205@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(206, 'User 206', 'FSG8711338', '2003-08-08', '9505479555', 'user206@example.com'),
(207, 'User 207', 'HNL6502796', '1922-10-01', '0024492098', 'user207@example.com'),
(208, 'User 208', 'WET4596034', '1920-03-01', '6450802587', 'user208@example.com'),
(209, 'User 209', 'RHO1137810', '1900-12-15', '1845202258', 'user209@example.com'),
(210, 'User 210', 'ZQW2116598', '1950-05-21', '8815401272', 'user210@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(211, 'User 211', 'MCZ6681547', '1976-10-07', '0911360436', 'user211@example.com'),
(212, 'User 212', 'YZJ2661281', '1990-06-26', '3484223640', 'user212@example.com'),
(213, 'User 213', 'NEK6252871', '1956-11-08', '8165414941', 'user213@example.com'),
(214, 'User 214', 'DKD2961691', '1939-06-23', '6349262939', 'user214@example.com'),
(215, 'User 215', 'HAI6417890', '1992-08-16', '3748463732', 'user215@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(216, 'User 216', 'WCF1874331', '1931-01-22', '3084677614', 'user216@example.com'),
(217, 'User 217', 'AWA0609258', '1904-04-25', '9661883104', 'user217@example.com'),
(218, 'User 218', 'YGK1493388', '1977-11-28', '7849804975', 'user218@example.com'),
(219, 'User 219', 'RLP0264947', '1909-03-16', '0605326910', 'user219@example.com'),
(220, 'User 220', 'DOO2393727', '1953-11-21', '7003181757', 'user220@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(221, 'User 221', 'TGA8033608', '1978-01-06', '3108980262', 'user221@example.com'),
(222, 'User 222', 'QIX9523562', '1907-10-26', '4208703460', 'user222@example.com'),
(223, 'User 223', 'LEK7788499', '1913-07-11', '3240662614', 'user223@example.com'),
(224, 'User 224', 'GFR7235269', '1925-10-06', '3319392871', 'user224@example.com'),
(225, 'User 225', 'ROT8125374', '1991-05-07', '4039355037', 'user225@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(226, 'User 226', 'NTW0753982', '1907-08-08', '5936754590', 'user226@example.com'),
(227, 'User 227', 'OTL1390148', '1931-12-01', '2584477948', 'user227@example.com'),
(228, 'User 228', 'GEU0581894', '1943-07-19', '5726255066', 'user228@example.com'),
(229, 'User 229', 'JEN7957266', '2005-07-12', '2557554087', 'user229@example.com'),
(230, 'User 230', 'LAW9252014', '1987-01-05', '9424377902', 'user230@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(231, 'User 231', 'ZWN0601299', '1901-09-27', '4752606029', 'user231@example.com'),
(232, 'User 232', 'SHW6479936', '1999-05-07', '5990875696', 'user232@example.com'),
(233, 'User 233', 'DGP3042480', '1911-06-21', '2266424662', 'user233@example.com'),
(234, 'User 234', 'RKS5066002', '1951-06-24', '8167751907', 'user234@example.com'),
(235, 'User 235', 'TJI4377676', '1917-08-26', '9162013137', 'user235@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(236, 'User 236', 'XTY6049320', '1995-05-22', '9197778605', 'user236@example.com'),
(237, 'User 237', 'HPO5818668', '1937-02-17', '0821035045', 'user237@example.com'),
(238, 'User 238', 'URQ9174556', '1916-11-07', '2868265445', 'user238@example.com'),
(239, 'User 239', 'QQV4135430', '2003-11-08', '6307943958', 'user239@example.com'),
(240, 'User 240', 'KAS8153498', '1935-01-04', '5124812155', 'user240@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(241, 'User 241', 'PXP4001007', '2003-11-16', '4157454184', 'user241@example.com'),
(242, 'User 242', 'UQH2631387', '1937-09-20', '7871071113', 'user242@example.com'),
(243, 'User 243', 'VQC7955317', '1970-12-03', '7091320292', 'user243@example.com'),
(244, 'User 244', 'ONB7334218', '1931-06-28', '9870187485', 'user244@example.com'),
(245, 'User 245', 'MES6882448', '1968-11-25', '9639556904', 'user245@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(246, 'User 246', 'NAL0440056', '1966-12-30', '7762432792', 'user246@example.com'),
(247, 'User 247', 'IEA3408045', '1970-01-11', '2500969643', 'user247@example.com'),
(248, 'User 248', 'OKW5786401', '1949-03-03', '8627456923', 'user248@example.com'),
(249, 'User 249', 'HJX4534764', '2005-01-25', '2127587090', 'user249@example.com'),
(250, 'User 250', 'UIJ9386326', '1964-03-18', '9747176682', 'user250@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(251, 'User 251', 'NNC5128266', '1981-11-26', '7363709222', 'user251@example.com'),
(252, 'User 252', 'NHB4728450', '1949-12-22', '4886379389', 'user252@example.com'),
(253, 'User 253', 'XLP6239091', '1941-12-07', '1849354183', 'user253@example.com'),
(254, 'User 254', 'UBP3534020', '1926-09-17', '6463447850', 'user254@example.com'),
(255, 'User 255', 'GLJ2255451', '1986-11-18', '6312383903', 'user255@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(256, 'User 256', 'FJL3580597', '1970-02-07', '3293446911', 'user256@example.com'),
(257, 'User 257', 'LTM1867564', '1949-08-29', '1301372678', 'user257@example.com'),
(258, 'User 258', 'ROV9717214', '1906-03-05', '4554049677', 'user258@example.com'),
(259, 'User 259', 'MIJ8900706', '1993-01-24', '0941573472', 'user259@example.com'),
(260, 'User 260', 'QCW3816679', '1975-10-12', '8695742758', 'user260@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(261, 'User 261', 'RPK1067375', '2000-11-15', '5119341753', 'user261@example.com'),
(262, 'User 262', 'PCQ1426584', '1953-10-24', '4328740161', 'user262@example.com'),
(263, 'User 263', 'CSK9306348', '1950-03-21', '5182015070', 'user263@example.com'),
(264, 'User 264', 'MNP3795008', '1904-07-16', '2316177172', 'user264@example.com'),
(265, 'User 265', 'OVJ9301212', '1964-12-21', '9466568678', 'user265@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(266, 'User 266', 'HKZ8879853', '1981-10-08', '1927448724', 'user266@example.com'),
(267, 'User 267', 'GYW5620506', '2002-05-02', '9419726153', 'user267@example.com'),
(268, 'User 268', 'WHD5790206', '1998-04-28', '5750511306', 'user268@example.com'),
(269, 'User 269', 'WHL3553118', '2003-06-21', '9530777628', 'user269@example.com'),
(270, 'User 270', 'YAN9899598', '1993-03-08', '2420605711', 'user270@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(271, 'User 271', 'BJD2126033', '1929-01-09', '0054850983', 'user271@example.com'),
(272, 'User 272', 'OSU6439450', '1955-10-17', '4873756340', 'user272@example.com'),
(273, 'User 273', 'UYC6780560', '1986-03-26', '8166009918', 'user273@example.com'),
(274, 'User 274', 'ADK1070662', '1936-10-27', '7528759305', 'user274@example.com'),
(275, 'User 275', 'YQC7983432', '1970-05-02', '4521419954', 'user275@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(276, 'User 276', 'WQF6999012', '1940-05-17', '5682895420', 'user276@example.com'),
(277, 'User 277', 'FPH3110215', '1965-09-30', '4216045134', 'user277@example.com'),
(278, 'User 278', 'NXA4436288', '1967-06-16', '3962868697', 'user278@example.com'),
(279, 'User 279', 'PBV9461722', '1921-07-17', '2564256440', 'user279@example.com'),
(280, 'User 280', 'MBE2504719', '1942-05-11', '2813459963', 'user280@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(281, 'User 281', 'QUB9235961', '1978-10-19', '5295337808', 'user281@example.com'),
(282, 'User 282', 'FKT3325444', '1993-04-11', '9439593032', 'user282@example.com'),
(283, 'User 283', 'CPQ4863644', '1981-10-14', '6039012875', 'user283@example.com'),
(284, 'User 284', 'YHG1720421', '2003-12-19', '8932796359', 'user284@example.com'),
(285, 'User 285', 'VMV6179291', '1918-01-24', '4218881306', 'user285@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(286, 'User 286', 'DRG1939295', '1951-12-29', '9940980579', 'user286@example.com'),
(287, 'User 287', 'PDA6627738', '1987-02-05', '2291459150', 'user287@example.com'),
(288, 'User 288', 'YSJ3188359', '1929-12-20', '3325206549', 'user288@example.com'),
(289, 'User 289', 'WOZ7926796', '1910-09-12', '3667425917', 'user289@example.com'),
(290, 'User 290', 'QZN3556818', '1988-12-21', '4213260274', 'user290@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(291, 'User 291', 'JMC1087185', '1987-12-29', '1573009824', 'user291@example.com'),
(292, 'User 292', 'HJV1967415', '1903-07-21', '3256671767', 'user292@example.com'),
(293, 'User 293', 'DMT8809265', '1916-05-10', '8445200572', 'user293@example.com'),
(294, 'User 294', 'JGP0175911', '1955-11-29', '6381032164', 'user294@example.com'),
(295, 'User 295', 'XZE2736797', '1955-07-22', '5685455987', 'user295@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(296, 'User 296', 'BPL1415652', '1958-12-24', '1509398167', 'user296@example.com'),
(297, 'User 297', 'QBY9735202', '1948-06-20', '7961271126', 'user297@example.com'),
(298, 'User 298', 'UOJ6059615', '1957-08-02', '2541499973', 'user298@example.com'),
(299, 'User 299', 'HVS5395767', '1987-02-04', '8879634476', 'user299@example.com'),
(300, 'User 300', 'YBY2428300', '1952-04-18', '9011399372', 'user300@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(301, 'User 301', 'YYE6109552', '2004-08-22', '1433519331', 'user301@example.com'),
(302, 'User 302', 'MEZ5777134', '1954-05-19', '4558447262', 'user302@example.com'),
(303, 'User 303', 'PNH9588214', '1939-12-18', '1204648295', 'user303@example.com'),
(304, 'User 304', 'WRN0327316', '1927-05-20', '6758480119', 'user304@example.com'),
(305, 'User 305', 'CBS6356360', '1952-03-30', '4150237300', 'user305@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(306, 'User 306', 'XSR2351470', '1925-05-01', '3105119367', 'user306@example.com'),
(307, 'User 307', 'BMK2948623', '1906-08-18', '1596446910', 'user307@example.com'),
(308, 'User 308', 'YGZ3461447', '1984-04-29', '5885254097', 'user308@example.com'),
(309, 'User 309', 'WRY5723225', '1933-02-21', '4939307612', 'user309@example.com'),
(310, 'User 310', 'GNA1069790', '1959-11-01', '6282525995', 'user310@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(311, 'User 311', 'DYQ3192342', '1913-12-04', '7942429240', 'user311@example.com'),
(312, 'User 312', 'TMD9247655', '1929-05-07', '5195492024', 'user312@example.com'),
(313, 'User 313', 'NYR9070937', '1920-08-07', '7960226478', 'user313@example.com'),
(314, 'User 314', 'XWI3197916', '1918-08-06', '7305892487', 'user314@example.com'),
(315, 'User 315', 'FTU7320282', '1996-01-12', '7994472726', 'user315@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(316, 'User 316', 'RJO6177089', '2003-04-11', '6843656185', 'user316@example.com'),
(317, 'User 317', 'LNN4663923', '1981-03-11', '7170621435', 'user317@example.com'),
(318, 'User 318', 'TMO4529550', '1982-05-15', '7632734234', 'user318@example.com'),
(319, 'User 319', 'CMW1568613', '1986-03-15', '2701898899', 'user319@example.com'),
(320, 'User 320', 'GTU2007471', '1942-11-22', '2918492180', 'user320@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(321, 'User 321', 'XMT7227453', '2004-09-10', '2858050549', 'user321@example.com'),
(322, 'User 322', 'UEY0859881', '1994-05-08', '8000049901', 'user322@example.com'),
(323, 'User 323', 'WXR6960939', '1993-02-12', '5017738342', 'user323@example.com'),
(324, 'User 324', 'LSL8333006', '1904-04-05', '8457751931', 'user324@example.com'),
(325, 'User 325', 'DNR2464624', '1958-11-16', '8949581323', 'user325@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(326, 'User 326', 'OQN5657136', '1977-02-07', '0168145637', 'user326@example.com'),
(327, 'User 327', 'HMP3447450', '1963-07-12', '9742803538', 'user327@example.com'),
(328, 'User 328', 'LXT0448023', '1915-03-25', '0250569610', 'user328@example.com'),
(329, 'User 329', 'WPB2238309', '1921-04-23', '9199221078', 'user329@example.com'),
(330, 'User 330', 'RMF7086855', '1946-08-05', '3216482565', 'user330@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(331, 'User 331', 'YDT1053035', '1966-04-11', '6343572456', 'user331@example.com'),
(332, 'User 332', 'SSX2592366', '1932-08-17', '2693733557', 'user332@example.com'),
(333, 'User 333', 'ZXZ1258811', '1904-09-11', '1299580238', 'user333@example.com'),
(334, 'User 334', 'OBL1693472', '1901-09-12', '8430026871', 'user334@example.com'),
(335, 'User 335', 'NCG7069603', '1966-04-18', '2780294528', 'user335@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(336, 'User 336', 'EQA8912694', '1939-08-28', '9022748262', 'user336@example.com'),
(337, 'User 337', 'EFM8715317', '2005-11-14', '4469698768', 'user337@example.com'),
(338, 'User 338', 'VXZ2903086', '1900-08-12', '3652346670', 'user338@example.com'),
(339, 'User 339', 'EOH8152181', '1915-08-20', '3621049259', 'user339@example.com'),
(340, 'User 340', 'QBT8080449', '1966-09-10', '8078409737', 'user340@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(341, 'User 341', 'HJZ9923931', '1994-06-12', '1835443031', 'user341@example.com'),
(342, 'User 342', 'XVO0475122', '1910-07-06', '4903332392', 'user342@example.com'),
(343, 'User 343', 'YGB8252188', '1900-10-20', '8831248594', 'user343@example.com'),
(344, 'User 344', 'ALC4314254', '1995-05-04', '2947227965', 'user344@example.com'),
(345, 'User 345', 'FTA5133530', '1900-01-30', '0153306732', 'user345@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(346, 'User 346', 'JYF4111694', '1949-05-09', '3356179548', 'user346@example.com'),
(347, 'User 347', 'KTX1590589', '1908-08-21', '6790366445', 'user347@example.com'),
(348, 'User 348', 'GUX9941281', '1936-03-06', '3982824569', 'user348@example.com'),
(349, 'User 349', 'HOB9738366', '1958-04-26', '5286517995', 'user349@example.com'),
(350, 'User 350', 'FEX4131032', '2002-05-09', '7672785684', 'user350@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(351, 'User 351', 'XOP3249126', '2004-04-21', '2211341674', 'user351@example.com'),
(352, 'User 352', 'OLM7933642', '1930-07-30', '8567972070', 'user352@example.com'),
(353, 'User 353', 'BWR8169810', '1951-11-23', '5199838633', 'user353@example.com'),
(354, 'User 354', 'AZZ4694604', '1943-04-16', '8963894480', 'user354@example.com'),
(355, 'User 355', 'YQM1854314', '1999-11-07', '1769336208', 'user355@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(356, 'User 356', 'LMY2750763', '1903-09-07', '2050501309', 'user356@example.com'),
(357, 'User 357', 'RZK9249870', '1983-02-14', '8560339675', 'user357@example.com'),
(358, 'User 358', 'YNZ1092239', '1997-02-22', '5562753638', 'user358@example.com'),
(359, 'User 359', 'ERF2715002', '1922-08-20', '2668679836', 'user359@example.com'),
(360, 'User 360', 'LBI4132094', '1988-04-15', '1720803437', 'user360@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(361, 'User 361', 'VGN2515077', '1973-07-10', '8571172160', 'user361@example.com'),
(362, 'User 362', 'KAO9503309', '1917-01-20', '8685578877', 'user362@example.com'),
(363, 'User 363', 'PZX4536375', '1919-02-27', '6048467365', 'user363@example.com'),
(364, 'User 364', 'DRU1786973', '1929-01-09', '1701629011', 'user364@example.com'),
(365, 'User 365', 'LKJ0307409', '1959-04-01', '6177850195', 'user365@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(366, 'User 366', 'RPE3792572', '1964-06-24', '1195202825', 'user366@example.com'),
(367, 'User 367', 'GJV3304018', '1974-04-25', '4304848292', 'user367@example.com'),
(368, 'User 368', 'OGU3409175', '1932-03-02', '4078103651', 'user368@example.com'),
(369, 'User 369', 'PNW0813991', '1948-01-08', '0620645160', 'user369@example.com'),
(370, 'User 370', 'FPS5288916', '1911-02-19', '1460141850', 'user370@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(371, 'User 371', 'COW9785282', '1987-09-19', '4117262129', 'user371@example.com'),
(372, 'User 372', 'HPJ1555352', '1931-02-15', '1591212926', 'user372@example.com'),
(373, 'User 373', 'FZN9506943', '1913-06-24', '2634491821', 'user373@example.com'),
(374, 'User 374', 'NOM6340777', '1913-01-06', '1112379731', 'user374@example.com'),
(375, 'User 375', 'LHK1585081', '1979-10-05', '6473560070', 'user375@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(376, 'User 376', 'ZIH7523143', '1956-07-12', '4341406984', 'user376@example.com'),
(377, 'User 377', 'NML1773835', '1965-10-08', '6930105982', 'user377@example.com'),
(378, 'User 378', 'ZZZ8591058', '1951-08-22', '1474246609', 'user378@example.com'),
(379, 'User 379', 'VTO1904785', '1966-03-23', '7585966643', 'user379@example.com'),
(380, 'User 380', 'XEV2253895', '1973-09-11', '6930259205', 'user380@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(381, 'User 381', 'ZHN7930076', '1977-07-03', '0217474309', 'user381@example.com'),
(382, 'User 382', 'GTV3580083', '2003-08-29', '7730550358', 'user382@example.com'),
(383, 'User 383', 'EWL2396226', '1962-05-28', '5561487598', 'user383@example.com'),
(384, 'User 384', 'CSP7473583', '1988-12-13', '3406655404', 'user384@example.com'),
(385, 'User 385', 'RGZ3113554', '2002-08-11', '0365286223', 'user385@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(386, 'User 386', 'MCO6440086', '1958-07-01', '6420278292', 'user386@example.com'),
(387, 'User 387', 'GAA3960551', '1997-09-01', '6338515991', 'user387@example.com'),
(388, 'User 388', 'OTH4811298', '1953-08-30', '2576389934', 'user388@example.com'),
(389, 'User 389', 'HWJ6506645', '1924-11-13', '6520060396', 'user389@example.com'),
(390, 'User 390', 'OMW5039403', '1904-01-06', '1083117063', 'user390@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(391, 'User 391', 'ZKF7550780', '1903-04-07', '6460926981', 'user391@example.com'),
(392, 'User 392', 'ONF3563110', '1937-02-27', '8905781358', 'user392@example.com'),
(393, 'User 393', 'AIH8369906', '1987-10-25', '6010701391', 'user393@example.com'),
(394, 'User 394', 'EUM4916620', '1968-11-11', '1840769684', 'user394@example.com'),
(395, 'User 395', 'WRU6892415', '1947-04-21', '8425324976', 'user395@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(396, 'User 396', 'TEP9574557', '1967-07-06', '4631622595', 'user396@example.com'),
(397, 'User 397', 'LHS9571238', '1963-06-17', '0545429142', 'user397@example.com'),
(398, 'User 398', 'BWZ8299240', '1901-07-05', '7121579737', 'user398@example.com'),
(399, 'User 399', 'OVJ1060139', '1948-11-03', '6541283206', 'user399@example.com'),
(400, 'User 400', 'OKJ5688931', '1953-09-12', '3373994302', 'user400@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(401, 'User 401', 'SVS2033721', '1911-03-04', '3570510982', 'user401@example.com'),
(402, 'User 402', 'MZQ4038815', '1987-08-09', '8376243580', 'user402@example.com'),
(403, 'User 403', 'ESI6568374', '1925-07-01', '1377427866', 'user403@example.com'),
(404, 'User 404', 'XMJ3391817', '1920-06-17', '8174399323', 'user404@example.com'),
(405, 'User 405', 'YCT9298768', '1976-09-10', '7593018883', 'user405@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(406, 'User 406', 'IAB6717170', '1942-05-21', '7852466827', 'user406@example.com'),
(407, 'User 407', 'ZTL6367300', '1921-03-23', '3726401366', 'user407@example.com'),
(408, 'User 408', 'ZZY6718933', '1931-03-28', '3444399184', 'user408@example.com'),
(409, 'User 409', 'EDS4644443', '1950-12-06', '2960103562', 'user409@example.com'),
(410, 'User 410', 'HJA8082608', '1919-12-25', '6883530419', 'user410@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(411, 'User 411', 'YWO3680723', '1966-02-06', '3586985473', 'user411@example.com'),
(412, 'User 412', 'NDM2018048', '1917-10-16', '7383778468', 'user412@example.com'),
(413, 'User 413', 'GHH8008844', '1973-06-30', '0460250540', 'user413@example.com'),
(414, 'User 414', 'OVQ1606835', '1926-12-28', '8686522574', 'user414@example.com'),
(415, 'User 415', 'WHK0997503', '2001-08-02', '8322714849', 'user415@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(416, 'User 416', 'KQR8868837', '1930-09-14', '5189100745', 'user416@example.com'),
(417, 'User 417', 'QVZ3670158', '1924-01-19', '9750031112', 'user417@example.com'),
(418, 'User 418', 'UXH0280158', '1930-04-29', '1504480949', 'user418@example.com'),
(419, 'User 419', 'BCO5024351', '1928-10-13', '2318746245', 'user419@example.com'),
(420, 'User 420', 'LPA9642849', '1976-07-07', '4561549327', 'user420@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(421, 'User 421', 'TDS2246530', '1962-06-14', '3537197637', 'user421@example.com'),
(422, 'User 422', 'QOX4508504', '1906-02-04', '3155906550', 'user422@example.com'),
(423, 'User 423', 'RAC8675700', '1905-06-29', '9422404858', 'user423@example.com'),
(424, 'User 424', 'ZLZ5506782', '1955-08-11', '1301511349', 'user424@example.com'),
(425, 'User 425', 'PIN9638324', '1930-07-18', '0056391607', 'user425@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(426, 'User 426', 'MQR5255698', '1923-08-05', '2968067727', 'user426@example.com'),
(427, 'User 427', 'WAN8707408', '1971-03-16', '5251919725', 'user427@example.com'),
(428, 'User 428', 'EFD7939611', '1991-06-14', '0330785502', 'user428@example.com'),
(429, 'User 429', 'KYM9658788', '1965-01-03', '4814217978', 'user429@example.com'),
(430, 'User 430', 'UPB5376851', '1998-01-27', '2977043523', 'user430@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(431, 'User 431', 'WMH4004863', '1921-06-05', '4218989061', 'user431@example.com'),
(432, 'User 432', 'JVJ1074836', '1932-11-14', '5297442734', 'user432@example.com'),
(433, 'User 433', 'TGF0731211', '1989-07-03', '8770023964', 'user433@example.com'),
(434, 'User 434', 'RSO1852597', '1900-06-05', '1905566536', 'user434@example.com'),
(435, 'User 435', 'REN1569012', '1970-07-12', '2185334190', 'user435@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(436, 'User 436', 'ELB1558735', '1969-01-20', '0158036879', 'user436@example.com'),
(437, 'User 437', 'TSK8402904', '1971-08-05', '2320107470', 'user437@example.com'),
(438, 'User 438', 'NTY6628118', '1956-05-24', '6931838038', 'user438@example.com'),
(439, 'User 439', 'XMU2014894', '1911-07-01', '8938933712', 'user439@example.com'),
(440, 'User 440', 'VAO4954884', '2001-01-08', '6282309257', 'user440@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(441, 'User 441', 'NDT1074630', '1989-09-09', '1327511177', 'user441@example.com'),
(442, 'User 442', 'HSJ3984749', '1940-07-23', '5329452239', 'user442@example.com'),
(443, 'User 443', 'VYR2437185', '1961-02-06', '1915130837', 'user443@example.com'),
(444, 'User 444', 'AJQ8733482', '1977-01-08', '5254400854', 'user444@example.com'),
(445, 'User 445', 'BWO0638488', '1931-12-24', '3030304584', 'user445@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(446, 'User 446', 'BMC5357652', '1998-04-23', '9518180844', 'user446@example.com'),
(447, 'User 447', 'DXM4480891', '1923-02-17', '2273311207', 'user447@example.com'),
(448, 'User 448', 'DZC4133907', '1939-10-17', '9950176189', 'user448@example.com'),
(449, 'User 449', 'QZU2402714', '1930-05-02', '1946645555', 'user449@example.com'),
(450, 'User 450', 'YYB3023680', '1956-07-21', '7200168558', 'user450@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(451, 'User 451', 'TIT8434514', '1936-10-18', '0091700915', 'user451@example.com'),
(452, 'User 452', 'CTZ3301324', '1902-03-08', '6348151732', 'user452@example.com'),
(453, 'User 453', 'UDK2242664', '1959-09-19', '7173690421', 'user453@example.com'),
(454, 'User 454', 'OAI9059242', '1990-03-29', '6870933211', 'user454@example.com'),
(455, 'User 455', 'JOP2163925', '1950-10-07', '6533717361', 'user455@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(456, 'User 456', 'BUT8445677', '1943-05-15', '6035239526', 'user456@example.com'),
(457, 'User 457', 'UMA9411530', '1917-09-07', '9279804753', 'user457@example.com'),
(458, 'User 458', 'CTD8724384', '1947-04-12', '3852341193', 'user458@example.com'),
(459, 'User 459', 'YBK5982170', '1957-08-13', '6801250243', 'user459@example.com'),
(460, 'User 460', 'HIB6971532', '1983-09-25', '5642525165', 'user460@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(461, 'User 461', 'JKF5390906', '2000-08-18', '4449365140', 'user461@example.com'),
(462, 'User 462', 'ZZV6433728', '1961-04-24', '1604930699', 'user462@example.com'),
(463, 'User 463', 'IOX6749492', '1970-01-07', '8900485534', 'user463@example.com'),
(464, 'User 464', 'DVU1431971', '1943-06-06', '4497405223', 'user464@example.com'),
(465, 'User 465', 'HAG1740506', '1943-02-18', '0232010239', 'user465@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(466, 'User 466', 'HFO2051926', '1982-12-13', '4735187456', 'user466@example.com'),
(467, 'User 467', 'SJB6325196', '1991-01-08', '2090948931', 'user467@example.com'),
(468, 'User 468', 'NKF4227035', '1972-05-09', '3994054274', 'user468@example.com'),
(469, 'User 469', 'KZC4685872', '1927-08-28', '4004812297', 'user469@example.com'),
(470, 'User 470', 'LZP9229602', '1966-01-22', '1664241999', 'user470@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(471, 'User 471', 'MOH5865608', '1933-11-27', '4319111067', 'user471@example.com'),
(472, 'User 472', 'FNB0639056', '1985-10-02', '2104910385', 'user472@example.com'),
(473, 'User 473', 'URQ3144892', '1953-08-01', '2016221812', 'user473@example.com'),
(474, 'User 474', 'WJI4985236', '1947-12-03', '9541868820', 'user474@example.com'),
(475, 'User 475', 'EGW4072916', '1907-12-20', '1106323041', 'user475@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(476, 'User 476', 'ITZ7359928', '1927-09-07', '8491308536', 'user476@example.com'),
(477, 'User 477', 'QWK9204006', '1924-03-25', '8128686386', 'user477@example.com'),
(478, 'User 478', 'DJR8332606', '1972-04-14', '5411319616', 'user478@example.com'),
(479, 'User 479', 'JVF6226562', '1909-10-11', '2478780219', 'user479@example.com'),
(480, 'User 480', 'AHB2051159', '1905-10-02', '1009548195', 'user480@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(481, 'User 481', 'RFP4094185', '1935-02-28', '7676570279', 'user481@example.com'),
(482, 'User 482', 'WEX9308358', '1922-12-05', '3329393836', 'user482@example.com'),
(483, 'User 483', 'FJC9320400', '1915-01-10', '4080770582', 'user483@example.com'),
(484, 'User 484', 'JIP8850687', '1909-03-07', '8198185428', 'user484@example.com'),
(485, 'User 485', 'LBO1479963', '1912-01-30', '9734571023', 'user485@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(486, 'User 486', 'UOY6430524', '1904-09-29', '4985953605', 'user486@example.com'),
(487, 'User 487', 'MKY1711793', '1989-06-13', '2989850480', 'user487@example.com'),
(488, 'User 488', 'CHT7666297', '1926-12-18', '0213888240', 'user488@example.com'),
(489, 'User 489', 'HXX7178033', '1946-12-17', '7457319664', 'user489@example.com'),
(490, 'User 490', 'QMD4038138', '1961-11-23', '3021725801', 'user490@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(491, 'User 491', 'FVJ6891013', '1966-08-02', '3095269624', 'user491@example.com'),
(492, 'User 492', 'RMP9819055', '1949-12-16', '6274281448', 'user492@example.com'),
(493, 'User 493', 'CZJ8585953', '1910-02-14', '6599232937', 'user493@example.com'),
(494, 'User 494', 'QHB1034471', '1961-10-26', '2655643414', 'user494@example.com'),
(495, 'User 495', 'VBA3529207', '1909-12-12', '2970698702', 'user495@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(496, 'User 496', 'DYG4837395', '1930-09-25', '2928930316', 'user496@example.com'),
(497, 'User 497', 'GFM1093764', '1952-02-16', '5229936881', 'user497@example.com'),
(498, 'User 498', 'STX0021419', '1988-08-16', '3852425622', 'user498@example.com'),
(499, 'User 499', 'SGH5157140', '1994-02-23', '3466485015', 'user499@example.com'),
(500, 'User 500', 'BOE9129555', '1978-08-05', '4880955968', 'user500@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(501, 'User 501', 'ZWZ5024736', '1990-06-05', '8718198421', 'user501@example.com'),
(502, 'User 502', 'XNQ6773252', '1949-02-21', '2626600463', 'user502@example.com'),
(503, 'User 503', 'AFD5469879', '1958-10-23', '7310807635', 'user503@example.com'),
(504, 'User 504', 'OGN6986263', '1945-12-12', '2279290138', 'user504@example.com'),
(505, 'User 505', 'RWX6212659', '1958-04-18', '2822411296', 'user505@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(506, 'User 506', 'DZU6609650', '1966-12-17', '9070476645', 'user506@example.com'),
(507, 'User 507', 'WFB6301967', '1963-06-05', '1676173768', 'user507@example.com'),
(508, 'User 508', 'GWD0921211', '1959-09-08', '5098888309', 'user508@example.com'),
(509, 'User 509', 'QHT5611666', '1990-03-07', '9858428998', 'user509@example.com'),
(510, 'User 510', 'HWI2529526', '2003-10-23', '9505533491', 'user510@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(511, 'User 511', 'AYS4272133', '1914-08-16', '7571290353', 'user511@example.com'),
(512, 'User 512', 'BLU3740780', '1952-12-25', '5561934245', 'user512@example.com'),
(513, 'User 513', 'FAM3700855', '1992-09-12', '4959503715', 'user513@example.com'),
(514, 'User 514', 'NCI6445674', '1999-04-14', '3100337780', 'user514@example.com'),
(515, 'User 515', 'GPM7714831', '1954-04-04', '9819082607', 'user515@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(516, 'User 516', 'GWC8335021', '1941-08-22', '4381739232', 'user516@example.com'),
(517, 'User 517', 'JJM1710521', '1991-10-23', '4529670933', 'user517@example.com'),
(518, 'User 518', 'UED8563976', '1976-04-27', '4045253029', 'user518@example.com'),
(519, 'User 519', 'APY9651178', '1907-11-21', '1588721187', 'user519@example.com'),
(520, 'User 520', 'VTQ8941654', '1935-02-23', '7707120962', 'user520@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(521, 'User 521', 'HAF8090248', '1901-06-04', '2152506035', 'user521@example.com'),
(522, 'User 522', 'PNH3611572', '1928-02-26', '8679531794', 'user522@example.com'),
(523, 'User 523', 'QON1947036', '1941-12-08', '5920534196', 'user523@example.com'),
(524, 'User 524', 'JHS6872131', '2002-11-24', '9802668837', 'user524@example.com'),
(525, 'User 525', 'BYN5527237', '1938-11-12', '7467757204', 'user525@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(526, 'User 526', 'UMC1096053', '1965-08-08', '2713364985', 'user526@example.com'),
(527, 'User 527', 'ECT1649073', '1979-06-14', '4342243351', 'user527@example.com'),
(528, 'User 528', 'LZC3913119', '1995-02-16', '9813761521', 'user528@example.com'),
(529, 'User 529', 'QWE5573359', '1997-11-18', '8318988258', 'user529@example.com'),
(530, 'User 530', 'RVL1117080', '1995-05-13', '3611048945', 'user530@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(531, 'User 531', 'ZUI2949589', '1902-01-02', '6487050747', 'user531@example.com'),
(532, 'User 532', 'XHZ0221016', '1993-06-19', '8477939040', 'user532@example.com'),
(533, 'User 533', 'OAV3631983', '1912-07-21', '7113206908', 'user533@example.com'),
(534, 'User 534', 'UBP0484055', '1977-12-02', '7652404512', 'user534@example.com'),
(535, 'User 535', 'UPA5226528', '1929-01-17', '6841837211', 'user535@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(536, 'User 536', 'WNZ8111693', '1959-03-28', '2105013358', 'user536@example.com'),
(537, 'User 537', 'YBT5711960', '2004-05-15', '0236053578', 'user537@example.com'),
(538, 'User 538', 'TYR4056359', '1906-11-14', '5406750174', 'user538@example.com'),
(539, 'User 539', 'ZSX7652057', '1993-08-27', '3536667997', 'user539@example.com'),
(540, 'User 540', 'ANQ5767003', '1996-10-06', '3338325166', 'user540@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(541, 'User 541', 'URQ8616416', '1944-02-03', '3287928862', 'user541@example.com'),
(542, 'User 542', 'RCH3373184', '2003-07-29', '7399147212', 'user542@example.com'),
(543, 'User 543', 'VPV1530435', '2002-11-25', '0675109866', 'user543@example.com'),
(544, 'User 544', 'WTK0314248', '1997-05-29', '5182595504', 'user544@example.com'),
(545, 'User 545', 'VZH6011635', '1999-12-19', '7794304530', 'user545@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(546, 'User 546', 'DVB9519656', '1975-08-16', '0667417281', 'user546@example.com'),
(547, 'User 547', 'JJU4064219', '1909-03-30', '8494096597', 'user547@example.com'),
(548, 'User 548', 'RFW2957049', '1954-08-16', '3879954513', 'user548@example.com'),
(549, 'User 549', 'ERC3441078', '1974-10-16', '4844507836', 'user549@example.com'),
(550, 'User 550', 'ZTK5214982', '1903-06-15', '3253612697', 'user550@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(551, 'User 551', 'MFG7930825', '1951-12-04', '8719157797', 'user551@example.com'),
(552, 'User 552', 'XPI0905323', '1915-11-02', '1710952340', 'user552@example.com'),
(553, 'User 553', 'CLU9294826', '1938-03-22', '8691846432', 'user553@example.com'),
(554, 'User 554', 'SRR7780414', '1987-06-22', '2422030983', 'user554@example.com'),
(555, 'User 555', 'AHV2906019', '1991-05-25', '1693087644', 'user555@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(556, 'User 556', 'XBN7219902', '1933-07-27', '3580818354', 'user556@example.com'),
(557, 'User 557', 'RHJ5013511', '1980-11-22', '4045039706', 'user557@example.com'),
(558, 'User 558', 'EWN0640768', '1986-11-23', '6598885647', 'user558@example.com'),
(559, 'User 559', 'UVM8353848', '1995-10-30', '5363453584', 'user559@example.com'),
(560, 'User 560', 'EYN8236704', '1906-04-20', '1295307655', 'user560@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(561, 'User 561', 'MUG5657363', '1933-04-16', '3248810315', 'user561@example.com'),
(562, 'User 562', 'QHP3293801', '1907-04-11', '5154775124', 'user562@example.com'),
(563, 'User 563', 'UMJ0023704', '1998-04-07', '1343612885', 'user563@example.com'),
(564, 'User 564', 'XJB8932859', '1946-04-13', '1357361541', 'user564@example.com'),
(565, 'User 565', 'HHR6240288', '1910-06-16', '9608565275', 'user565@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(566, 'User 566', 'VSA6721329', '1918-07-11', '8252602322', 'user566@example.com'),
(567, 'User 567', 'ZQJ4237580', '1979-04-05', '7203345351', 'user567@example.com'),
(568, 'User 568', 'QLY5629442', '1987-02-04', '1848631781', 'user568@example.com'),
(569, 'User 569', 'DXQ8780996', '1982-02-18', '2921382573', 'user569@example.com'),
(570, 'User 570', 'GZV7220923', '1922-06-05', '3364592776', 'user570@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(571, 'User 571', 'WBT4804418', '2003-09-21', '9587552089', 'user571@example.com'),
(572, 'User 572', 'VSJ8507274', '1925-01-27', '4181275371', 'user572@example.com'),
(573, 'User 573', 'VUA7690448', '1987-04-14', '1549774022', 'user573@example.com'),
(574, 'User 574', 'AGB9829362', '1900-11-06', '9043453149', 'user574@example.com'),
(575, 'User 575', 'YXK9227037', '1950-10-04', '8727918812', 'user575@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(576, 'User 576', 'NON1029462', '1925-01-19', '8572517371', 'user576@example.com'),
(577, 'User 577', 'MDZ7378684', '1996-04-14', '9581447581', 'user577@example.com'),
(578, 'User 578', 'MUL1743809', '1971-03-10', '2923635709', 'user578@example.com'),
(579, 'User 579', 'AOU0911860', '1997-10-02', '1977309939', 'user579@example.com'),
(580, 'User 580', 'QYR4377479', '1954-10-03', '3168314126', 'user580@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(581, 'User 581', 'AMA4792682', '1902-05-20', '2448418721', 'user581@example.com'),
(582, 'User 582', 'MHM6595784', '1921-02-27', '9998652405', 'user582@example.com'),
(583, 'User 583', 'VDM6310625', '1945-09-11', '5301339713', 'user583@example.com'),
(584, 'User 584', 'LGC1705028', '1912-10-18', '4245845026', 'user584@example.com'),
(585, 'User 585', 'ZIP3273640', '1981-12-20', '0432237457', 'user585@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(586, 'User 586', 'FWV4507160', '1923-08-02', '5913433136', 'user586@example.com'),
(587, 'User 587', 'QAR4904542', '1900-02-13', '9693389787', 'user587@example.com'),
(588, 'User 588', 'WFE4099651', '1974-05-12', '4786664372', 'user588@example.com'),
(589, 'User 589', 'QEU9532329', '1995-10-24', '9237180360', 'user589@example.com'),
(590, 'User 590', 'SRT3005429', '1946-02-17', '4787900260', 'user590@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(591, 'User 591', 'OID0609586', '1913-09-14', '9894320898', 'user591@example.com'),
(592, 'User 592', 'ABU7623669', '1989-11-25', '2593572920', 'user592@example.com'),
(593, 'User 593', 'GEK5309814', '1959-08-21', '2159780008', 'user593@example.com'),
(594, 'User 594', 'LJD2510416', '2005-10-15', '1331127211', 'user594@example.com'),
(595, 'User 595', 'UPX7849655', '1953-10-25', '2533880342', 'user595@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(596, 'User 596', 'ECT7458440', '1985-12-09', '5978643421', 'user596@example.com'),
(597, 'User 597', 'TOC3760403', '1972-06-09', '5969512851', 'user597@example.com'),
(598, 'User 598', 'AQQ8222001', '1968-02-09', '3682683335', 'user598@example.com'),
(599, 'User 599', 'QRK4269482', '1930-01-15', '2501764610', 'user599@example.com'),
(600, 'User 600', 'DAG0367136', '1999-08-24', '1678132650', 'user600@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(601, 'User 601', 'HRW2869341', '1968-03-03', '2799750786', 'user601@example.com'),
(602, 'User 602', 'WMF7080933', '1972-04-04', '4335059031', 'user602@example.com'),
(603, 'User 603', 'OLM2776594', '1920-07-08', '1540893670', 'user603@example.com'),
(604, 'User 604', 'JXO3509166', '2004-04-17', '3643375329', 'user604@example.com'),
(605, 'User 605', 'APM8060904', '1958-10-24', '0923440497', 'user605@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(606, 'User 606', 'AQG4472056', '1914-02-16', '8920442393', 'user606@example.com'),
(607, 'User 607', 'KEW2647634', '1957-11-08', '5464525802', 'user607@example.com'),
(608, 'User 608', 'XOJ8783854', '1924-06-11', '8274400253', 'user608@example.com'),
(609, 'User 609', 'RHK8700546', '1961-01-04', '8047272646', 'user609@example.com'),
(610, 'User 610', 'CPT8384495', '1945-01-21', '0971012282', 'user610@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(611, 'User 611', 'YOG5782889', '1983-09-12', '4067018805', 'user611@example.com'),
(612, 'User 612', 'VXE4207898', '1985-04-21', '5249048737', 'user612@example.com'),
(613, 'User 613', 'FSM0201604', '1909-03-23', '9385040580', 'user613@example.com'),
(614, 'User 614', 'VZO2762597', '1971-10-17', '5194330749', 'user614@example.com'),
(615, 'User 615', 'OFO8458165', '1965-10-20', '0978484706', 'user615@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(616, 'User 616', 'EUS2089518', '1990-02-01', '7531543199', 'user616@example.com'),
(617, 'User 617', 'DMY2444440', '1953-03-10', '2295138753', 'user617@example.com'),
(618, 'User 618', 'NET3008715', '1982-09-27', '6006017650', 'user618@example.com'),
(619, 'User 619', 'NMH3662249', '1987-10-25', '3122041114', 'user619@example.com'),
(620, 'User 620', 'JEW0712963', '1979-11-19', '5259511703', 'user620@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(621, 'User 621', 'LTZ5966185', '1923-01-28', '7878602037', 'user621@example.com'),
(622, 'User 622', 'HSW4090806', '1991-09-04', '8400665023', 'user622@example.com'),
(623, 'User 623', 'TEH5759000', '1918-06-29', '2197677778', 'user623@example.com'),
(624, 'User 624', 'JEK4553990', '1998-01-16', '9841851663', 'user624@example.com'),
(625, 'User 625', 'JIQ6276572', '1996-08-11', '7163606277', 'user625@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(626, 'User 626', 'ECA9513661', '1973-08-27', '3173835891', 'user626@example.com'),
(627, 'User 627', 'NFU9013728', '1945-06-22', '5574195700', 'user627@example.com'),
(628, 'User 628', 'WMF9947297', '1929-12-30', '0996641524', 'user628@example.com'),
(629, 'User 629', 'OYN5677130', '1995-02-05', '0442857597', 'user629@example.com'),
(630, 'User 630', 'LUI2296745', '1967-10-30', '1050559585', 'user630@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(631, 'User 631', 'BEC6166247', '2000-04-30', '8099955035', 'user631@example.com'),
(632, 'User 632', 'SIO6413940', '1910-07-12', '3004847884', 'user632@example.com'),
(633, 'User 633', 'SAC4697416', '1959-08-30', '5449052688', 'user633@example.com'),
(634, 'User 634', 'BSN0242261', '1953-06-05', '6090492571', 'user634@example.com'),
(635, 'User 635', 'HCB4473728', '1986-05-18', '4290358606', 'user635@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(636, 'User 636', 'DQA2590544', '1946-11-28', '2069600409', 'user636@example.com'),
(637, 'User 637', 'VCY1992886', '1984-03-08', '9342169616', 'user637@example.com'),
(638, 'User 638', 'ARN1797751', '1950-05-09', '6722274217', 'user638@example.com'),
(639, 'User 639', 'FSD3170324', '1905-11-22', '8454309496', 'user639@example.com'),
(640, 'User 640', 'WSF8497469', '1952-02-16', '9232769485', 'user640@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(641, 'User 641', 'HIW2269015', '1979-03-12', '5054804633', 'user641@example.com'),
(642, 'User 642', 'RZX1244480', '1911-02-01', '1786599132', 'user642@example.com'),
(643, 'User 643', 'BTG8603753', '1976-08-28', '8042341776', 'user643@example.com'),
(644, 'User 644', 'WFP0023259', '1998-03-15', '3219185481', 'user644@example.com'),
(645, 'User 645', 'ETA8512675', '1946-01-26', '1917796059', 'user645@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(646, 'User 646', 'GYA9323881', '1952-05-14', '4749334069', 'user646@example.com'),
(647, 'User 647', 'RWT3795526', '1993-03-05', '0762857889', 'user647@example.com'),
(648, 'User 648', 'DCV6022865', '1918-08-22', '6208119492', 'user648@example.com'),
(649, 'User 649', 'UIU6290650', '1990-03-08', '4342514774', 'user649@example.com'),
(650, 'User 650', 'JWX7493993', '2000-02-08', '2785603534', 'user650@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(651, 'User 651', 'KXI7953400', '1930-01-22', '6806473007', 'user651@example.com'),
(652, 'User 652', 'UHV8829033', '1973-08-16', '9498023971', 'user652@example.com'),
(653, 'User 653', 'JTS2288203', '1986-04-06', '3794972743', 'user653@example.com'),
(654, 'User 654', 'TNP8236197', '1989-12-23', '4823745167', 'user654@example.com'),
(655, 'User 655', 'LTY9410256', '1962-01-02', '7614143039', 'user655@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(656, 'User 656', 'EPA4862189', '1940-04-29', '2945826236', 'user656@example.com'),
(657, 'User 657', 'LNR6009269', '1986-11-14', '7420088540', 'user657@example.com'),
(658, 'User 658', 'OOU3005844', '1944-12-13', '3966103747', 'user658@example.com'),
(659, 'User 659', 'NBU6240306', '1974-06-08', '4768403590', 'user659@example.com'),
(660, 'User 660', 'BLJ5042205', '1967-04-05', '0005762144', 'user660@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(661, 'User 661', 'IXW5506584', '1978-08-23', '9868531412', 'user661@example.com'),
(662, 'User 662', 'DNH5606135', '1913-08-24', '9685144214', 'user662@example.com'),
(663, 'User 663', 'YON3065672', '1908-06-02', '9470325743', 'user663@example.com'),
(664, 'User 664', 'TAY7235408', '1932-05-30', '9868526496', 'user664@example.com'),
(665, 'User 665', 'CWQ4643768', '1939-03-12', '8876801442', 'user665@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(666, 'User 666', 'WTF1398819', '1904-10-16', '5412869265', 'user666@example.com'),
(667, 'User 667', 'MHM3447666', '1916-06-30', '0263169959', 'user667@example.com'),
(668, 'User 668', 'PNO9742747', '1980-04-04', '6067558672', 'user668@example.com'),
(669, 'User 669', 'QTR8515575', '1929-10-20', '3291747383', 'user669@example.com'),
(670, 'User 670', 'GCO0826073', '1937-10-05', '0260433397', 'user670@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(671, 'User 671', 'RNF5659699', '1906-02-21', '9712745138', 'user671@example.com'),
(672, 'User 672', 'EOC9186872', '1990-02-24', '1320210169', 'user672@example.com'),
(673, 'User 673', 'SHX0727199', '1984-01-13', '7421993851', 'user673@example.com'),
(674, 'User 674', 'DZW4978746', '1939-06-24', '1776248215', 'user674@example.com'),
(675, 'User 675', 'KID9620757', '1922-09-15', '7479345229', 'user675@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(676, 'User 676', 'OKK9260816', '1987-06-11', '0519305477', 'user676@example.com'),
(677, 'User 677', 'LET5600783', '1957-04-21', '5256906994', 'user677@example.com'),
(678, 'User 678', 'FDD8307452', '1930-04-27', '0139942984', 'user678@example.com'),
(679, 'User 679', 'AOP1523366', '1997-05-17', '7345339054', 'user679@example.com'),
(680, 'User 680', 'JYM6840680', '1928-05-05', '6582864387', 'user680@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(681, 'User 681', 'SGM5845146', '1985-02-25', '9239665957', 'user681@example.com'),
(682, 'User 682', 'DFS4238093', '1935-08-22', '4030689242', 'user682@example.com'),
(683, 'User 683', 'ZXM1571844', '1927-07-01', '7086459331', 'user683@example.com'),
(684, 'User 684', 'TSX8055292', '1966-10-01', '1632723600', 'user684@example.com'),
(685, 'User 685', 'MIP1482755', '1928-10-20', '3957216293', 'user685@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(686, 'User 686', 'ZFR5381449', '1970-05-12', '2306612445', 'user686@example.com'),
(687, 'User 687', 'TFX8927258', '2004-05-11', '0285960410', 'user687@example.com'),
(688, 'User 688', 'SHX1502240', '1955-09-18', '7968446686', 'user688@example.com'),
(689, 'User 689', 'CDP3978088', '1929-12-20', '7991964585', 'user689@example.com'),
(690, 'User 690', 'RGQ3186000', '1988-09-10', '6690557746', 'user690@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(691, 'User 691', 'PDV8314898', '1982-01-18', '3282176392', 'user691@example.com'),
(692, 'User 692', 'PEJ4612807', '1948-08-28', '8752914627', 'user692@example.com'),
(693, 'User 693', 'TNV1860509', '2003-09-10', '2859892911', 'user693@example.com'),
(694, 'User 694', 'GBG3160333', '1928-01-18', '1371794492', 'user694@example.com'),
(695, 'User 695', 'KAV1603917', '1968-04-09', '5288520213', 'user695@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(696, 'User 696', 'VQA9048773', '1925-06-11', '8992755681', 'user696@example.com'),
(697, 'User 697', 'OHD2971789', '1977-12-02', '5235937942', 'user697@example.com'),
(698, 'User 698', 'UJI4774565', '1995-12-12', '7870398742', 'user698@example.com'),
(699, 'User 699', 'UWT2602164', '1919-05-12', '5779736074', 'user699@example.com'),
(700, 'User 700', 'JFT6300968', '1993-06-17', '3553572318', 'user700@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(701, 'User 701', 'UOX2461244', '1940-08-27', '0977769101', 'user701@example.com'),
(702, 'User 702', 'DHE1518982', '1951-11-15', '4666339674', 'user702@example.com'),
(703, 'User 703', 'ALO2465114', '1928-06-08', '8850720005', 'user703@example.com'),
(704, 'User 704', 'YKB4504075', '2000-03-23', '8419801098', 'user704@example.com'),
(705, 'User 705', 'XWK4178076', '1983-05-06', '2288647475', 'user705@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(706, 'User 706', 'DVW7188333', '1999-04-05', '9527281534', 'user706@example.com'),
(707, 'User 707', 'MOF0329413', '1904-08-07', '7266310541', 'user707@example.com'),
(708, 'User 708', 'ASA5096311', '1974-03-13', '1282048269', 'user708@example.com'),
(709, 'User 709', 'DCQ0902891', '1995-12-18', '2969396456', 'user709@example.com'),
(710, 'User 710', 'OFX9502538', '1904-01-25', '6873330577', 'user710@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(711, 'User 711', 'RMY4227021', '1918-04-05', '8350453808', 'user711@example.com'),
(712, 'User 712', 'ACT2332098', '1958-04-17', '3468745332', 'user712@example.com'),
(713, 'User 713', 'EEO2118390', '1902-06-20', '1716821771', 'user713@example.com'),
(714, 'User 714', 'IPB0711597', '1927-09-12', '1719611671', 'user714@example.com'),
(715, 'User 715', 'KVI4896947', '1992-12-27', '2575427910', 'user715@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(716, 'User 716', 'QQE6029738', '1938-12-30', '0499511106', 'user716@example.com'),
(717, 'User 717', 'VNH2615985', '1990-03-08', '7499795422', 'user717@example.com'),
(718, 'User 718', 'MZS8405497', '1930-05-20', '4567377967', 'user718@example.com'),
(719, 'User 719', 'VSI3210357', '1990-12-20', '4629141343', 'user719@example.com'),
(720, 'User 720', 'TWO8488892', '1943-10-15', '4543279025', 'user720@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(721, 'User 721', 'HKJ5194173', '1912-10-03', '4705645444', 'user721@example.com'),
(722, 'User 722', 'DKG8770024', '2001-03-19', '3620307671', 'user722@example.com'),
(723, 'User 723', 'ABA4872228', '2001-08-18', '5903242615', 'user723@example.com'),
(724, 'User 724', 'HYC4170140', '1947-03-27', '5091880235', 'user724@example.com'),
(725, 'User 725', 'VAZ8319428', '1992-06-21', '5798512636', 'user725@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(726, 'User 726', 'KNN0592494', '1940-02-13', '7595627298', 'user726@example.com'),
(727, 'User 727', 'JRJ5853604', '1947-04-05', '1190549156', 'user727@example.com'),
(728, 'User 728', 'LOG1402295', '1958-03-19', '5767255429', 'user728@example.com'),
(729, 'User 729', 'OWI5742040', '1959-03-01', '7717505978', 'user729@example.com'),
(730, 'User 730', 'BOT7516029', '1946-04-18', '1583730461', 'user730@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(731, 'User 731', 'GPU0623532', '2000-01-14', '5680884869', 'user731@example.com'),
(732, 'User 732', 'PJA8692015', '1959-10-01', '3824040729', 'user732@example.com'),
(733, 'User 733', 'BSS5365342', '1929-05-02', '4826294479', 'user733@example.com'),
(734, 'User 734', 'YGC6055734', '1996-04-12', '3142925184', 'user734@example.com'),
(735, 'User 735', 'UPV4235906', '1975-08-11', '7624709827', 'user735@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(736, 'User 736', 'NSP1374249', '1957-02-16', '6089814997', 'user736@example.com'),
(737, 'User 737', 'WRB7484909', '1909-09-28', '6692287566', 'user737@example.com'),
(738, 'User 738', 'GFD6247171', '1988-12-22', '3059474729', 'user738@example.com'),
(739, 'User 739', 'LMU6781746', '1973-02-04', '4846136402', 'user739@example.com'),
(740, 'User 740', 'RLD4906238', '1914-10-13', '6999450337', 'user740@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(741, 'User 741', 'ZCL2554337', '1918-05-23', '3606860150', 'user741@example.com'),
(742, 'User 742', 'KLN1519616', '1911-10-07', '6666156420', 'user742@example.com'),
(743, 'User 743', 'PWG7040092', '1948-08-07', '0988724442', 'user743@example.com'),
(744, 'User 744', 'FJG1050507', '1981-11-14', '0448861276', 'user744@example.com'),
(745, 'User 745', 'ASK8535042', '1965-04-08', '4185791695', 'user745@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(746, 'User 746', 'FQG7221326', '2000-01-04', '7374977377', 'user746@example.com'),
(747, 'User 747', 'RRS6058813', '1998-06-09', '1576048986', 'user747@example.com'),
(748, 'User 748', 'LCV5800889', '1941-03-19', '5522935139', 'user748@example.com'),
(749, 'User 749', 'IET6561257', '1951-01-14', '5722318701', 'user749@example.com'),
(750, 'User 750', 'KAW7785162', '1904-09-02', '0374232125', 'user750@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(751, 'User 751', 'AHP7460645', '1940-08-08', '7673576330', 'user751@example.com'),
(752, 'User 752', 'ILQ5159681', '1939-05-18', '1152094646', 'user752@example.com'),
(753, 'User 753', 'OEB1102178', '1997-05-24', '1230495761', 'user753@example.com'),
(754, 'User 754', 'FLS1479389', '1920-01-27', '1248969358', 'user754@example.com'),
(755, 'User 755', 'FRV8424803', '1950-09-25', '0858049354', 'user755@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(756, 'User 756', 'JLL1123217', '1946-05-09', '2293959230', 'user756@example.com'),
(757, 'User 757', 'BTI8329526', '1930-01-23', '3608857372', 'user757@example.com'),
(758, 'User 758', 'KXW0789721', '1966-04-07', '8207304095', 'user758@example.com'),
(759, 'User 759', 'QGZ9185511', '1934-05-03', '9139549879', 'user759@example.com'),
(760, 'User 760', 'RQN7978134', '1924-06-06', '3230095361', 'user760@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(761, 'User 761', 'VHM1007892', '1979-08-30', '8694666051', 'user761@example.com'),
(762, 'User 762', 'NAR8047621', '1955-03-10', '8717985002', 'user762@example.com'),
(763, 'User 763', 'CJG9202387', '1951-12-23', '8192398355', 'user763@example.com'),
(764, 'User 764', 'QWW9523993', '1912-01-30', '0490736229', 'user764@example.com'),
(765, 'User 765', 'YKZ3049307', '1984-10-23', '0759844985', 'user765@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(766, 'User 766', 'CGR1242864', '1993-08-16', '7797130275', 'user766@example.com'),
(767, 'User 767', 'XSV2363389', '1925-01-19', '4991537196', 'user767@example.com'),
(768, 'User 768', 'WNU3672802', '1929-05-24', '3748761176', 'user768@example.com'),
(769, 'User 769', 'XHS6572249', '1997-11-12', '6914848283', 'user769@example.com'),
(770, 'User 770', 'BNR3239035', '1908-02-22', '1008867002', 'user770@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(771, 'User 771', 'KIN0791043', '1992-10-18', '4175923981', 'user771@example.com'),
(772, 'User 772', 'QSX7725821', '1932-02-15', '9306614769', 'user772@example.com'),
(773, 'User 773', 'HIM0042955', '1925-02-17', '6102622304', 'user773@example.com'),
(774, 'User 774', 'OBZ1757075', '1909-03-22', '4278412441', 'user774@example.com'),
(775, 'User 775', 'LVM0036841', '1914-05-19', '7867486997', 'user775@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(776, 'User 776', 'TLJ0331199', '1966-02-14', '7501980712', 'user776@example.com'),
(777, 'User 777', 'QGA4176585', '1973-02-02', '6473616052', 'user777@example.com'),
(778, 'User 778', 'NUC7732028', '1975-10-14', '2214346509', 'user778@example.com'),
(779, 'User 779', 'CPI3174408', '1914-01-28', '6208878790', 'user779@example.com'),
(780, 'User 780', 'FXE0803567', '1905-12-06', '0588664383', 'user780@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(781, 'User 781', 'DQO5370112', '1992-06-06', '4065005410', 'user781@example.com'),
(782, 'User 782', 'MKS9029068', '1982-04-26', '3652402151', 'user782@example.com'),
(783, 'User 783', 'VLJ9468672', '1909-09-10', '5749965262', 'user783@example.com'),
(784, 'User 784', 'RVB0761496', '1980-05-20', '3016603003', 'user784@example.com'),
(785, 'User 785', 'FQK4870351', '1995-12-10', '7304400309', 'user785@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(786, 'User 786', 'TYO9274796', '1924-08-29', '8470643103', 'user786@example.com'),
(787, 'User 787', 'ECU4177469', '1904-12-10', '1844028714', 'user787@example.com'),
(788, 'User 788', 'XUV6473448', '1975-11-22', '1325062877', 'user788@example.com'),
(789, 'User 789', 'NOP5836435', '1964-02-26', '3558714722', 'user789@example.com'),
(790, 'User 790', 'JEM1292979', '1967-01-18', '6034286906', 'user790@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(791, 'User 791', 'EMB8626554', '1926-07-26', '5753957495', 'user791@example.com'),
(792, 'User 792', 'MWN8506796', '1947-11-02', '8459958137', 'user792@example.com'),
(793, 'User 793', 'ONC4989007', '1980-11-20', '3925376577', 'user793@example.com'),
(794, 'User 794', 'ANK6585830', '1924-01-05', '4000110801', 'user794@example.com'),
(795, 'User 795', 'XPK3287822', '1931-02-21', '0337448986', 'user795@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(796, 'User 796', 'XGL9030075', '1916-09-22', '9297118673', 'user796@example.com'),
(797, 'User 797', 'KDO3417721', '1990-08-24', '7863328805', 'user797@example.com'),
(798, 'User 798', 'EZT7797763', '1923-09-18', '9992847321', 'user798@example.com'),
(799, 'User 799', 'GGF1702384', '1965-06-08', '9728393790', 'user799@example.com'),
(800, 'User 800', 'FWU8661955', '1984-03-12', '2699860891', 'user800@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(801, 'User 801', 'KNP1867867', '1946-01-26', '5913475302', 'user801@example.com'),
(802, 'User 802', 'MAL4469500', '1975-02-10', '4456551529', 'user802@example.com'),
(803, 'User 803', 'GAS6871629', '1961-11-16', '2469413835', 'user803@example.com'),
(804, 'User 804', 'EJI6481023', '1902-01-24', '1555271525', 'user804@example.com'),
(805, 'User 805', 'NVZ5199577', '1977-03-30', '4055955527', 'user805@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(806, 'User 806', 'YVW1440886', '1903-02-27', '1324907690', 'user806@example.com'),
(807, 'User 807', 'WDJ4463002', '2002-06-07', '0847487018', 'user807@example.com'),
(808, 'User 808', 'ERL1353873', '1915-03-15', '5669206687', 'user808@example.com'),
(809, 'User 809', 'ZPG5197636', '1918-04-06', '1822859626', 'user809@example.com'),
(810, 'User 810', 'KMZ5393855', '1904-12-16', '2895265118', 'user810@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(811, 'User 811', 'TVH2997023', '1995-07-26', '5538823637', 'user811@example.com'),
(812, 'User 812', 'TAA7856973', '1920-07-11', '4300047613', 'user812@example.com'),
(813, 'User 813', 'JES8162232', '1981-05-07', '1280302942', 'user813@example.com'),
(814, 'User 814', 'OEW3466335', '1909-08-22', '5988118673', 'user814@example.com'),
(815, 'User 815', 'MIA9334392', '1937-10-18', '2319233509', 'user815@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(816, 'User 816', 'AUF4731596', '1996-11-21', '7569605921', 'user816@example.com'),
(817, 'User 817', 'HQE9017137', '1983-04-14', '1093440172', 'user817@example.com'),
(818, 'User 818', 'XTV6276177', '1929-01-03', '6157538752', 'user818@example.com'),
(819, 'User 819', 'YUZ3238450', '1952-06-14', '6702625268', 'user819@example.com'),
(820, 'User 820', 'YPQ2923351', '1955-09-18', '0888444370', 'user820@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(821, 'User 821', 'CCJ0778382', '1992-11-28', '2781659360', 'user821@example.com'),
(822, 'User 822', 'XWO1309405', '1996-11-17', '3377205602', 'user822@example.com'),
(823, 'User 823', 'YVO6584355', '1908-03-14', '3489027984', 'user823@example.com'),
(824, 'User 824', 'VET0021762', '1973-03-19', '2059405786', 'user824@example.com'),
(825, 'User 825', 'TQI3425175', '1914-02-27', '8661145070', 'user825@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(826, 'User 826', 'UDT9391780', '1912-02-16', '7395254864', 'user826@example.com'),
(827, 'User 827', 'MVQ3195160', '1923-05-26', '6392941240', 'user827@example.com'),
(828, 'User 828', 'VRC9967957', '1968-04-27', '6354926797', 'user828@example.com'),
(829, 'User 829', 'NGK3784459', '1939-11-05', '2542992231', 'user829@example.com'),
(830, 'User 830', 'MQG7911940', '1934-08-03', '8263811654', 'user830@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(831, 'User 831', 'TLE2805798', '1948-03-25', '0018465308', 'user831@example.com'),
(832, 'User 832', 'DBG9454119', '1905-05-06', '2792682925', 'user832@example.com'),
(833, 'User 833', 'JVQ5035534', '1915-03-01', '8928425796', 'user833@example.com'),
(834, 'User 834', 'UTR4388813', '1961-08-24', '4651043053', 'user834@example.com'),
(835, 'User 835', 'ERV9596801', '1931-09-13', '2076577781', 'user835@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(836, 'User 836', 'DGM7887627', '1925-03-04', '5686268356', 'user836@example.com'),
(837, 'User 837', 'RHE2535477', '1967-04-11', '1548422369', 'user837@example.com'),
(838, 'User 838', 'ZFX0800843', '1990-04-02', '6907547991', 'user838@example.com'),
(839, 'User 839', 'OAL3498069', '1994-07-23', '7830363127', 'user839@example.com'),
(840, 'User 840', 'JUL9529863', '2000-04-09', '7893612222', 'user840@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(841, 'User 841', 'QMI7619630', '1989-02-06', '8814588254', 'user841@example.com'),
(842, 'User 842', 'HET8596265', '1964-07-20', '0833200687', 'user842@example.com'),
(843, 'User 843', 'IWA2715814', '1950-07-08', '2541447384', 'user843@example.com'),
(844, 'User 844', 'HNS4922808', '1900-03-28', '4406412723', 'user844@example.com'),
(845, 'User 845', 'BJW1158471', '1951-12-27', '4545056899', 'user845@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(846, 'User 846', 'KXS8457683', '1941-07-22', '6287912313', 'user846@example.com'),
(847, 'User 847', 'LRP9665112', '1960-04-07', '9494420776', 'user847@example.com'),
(848, 'User 848', 'VDQ3723757', '1954-12-18', '3121699261', 'user848@example.com'),
(849, 'User 849', 'TXC8245334', '1969-04-24', '8227169807', 'user849@example.com'),
(850, 'User 850', 'NQI0266669', '1994-03-12', '0827176487', 'user850@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(851, 'User 851', 'TVS0439669', '1955-10-28', '2880413676', 'user851@example.com'),
(852, 'User 852', 'QQN1353262', '1999-03-20', '5689315508', 'user852@example.com'),
(853, 'User 853', 'PIO6813669', '1964-06-26', '3853247972', 'user853@example.com'),
(854, 'User 854', 'XMT9626444', '1955-06-19', '6890170358', 'user854@example.com'),
(855, 'User 855', 'PCK9273639', '2000-02-24', '5728862178', 'user855@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(856, 'User 856', 'NYI0938067', '1949-05-25', '9397704088', 'user856@example.com'),
(857, 'User 857', 'NVJ2899081', '1936-01-04', '5344096397', 'user857@example.com'),
(858, 'User 858', 'CIM7987449', '1978-09-03', '2963974773', 'user858@example.com'),
(859, 'User 859', 'UCU3426750', '1965-11-09', '9295423317', 'user859@example.com'),
(860, 'User 860', 'ICN4532475', '1918-12-27', '6787789271', 'user860@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(861, 'User 861', 'OAC8670955', '1996-02-15', '8995017191', 'user861@example.com'),
(862, 'User 862', 'DWM4128196', '1988-03-24', '6242599130', 'user862@example.com'),
(863, 'User 863', 'PAW3493093', '1974-05-16', '4097667724', 'user863@example.com'),
(864, 'User 864', 'BFF0360002', '1971-07-11', '4397237542', 'user864@example.com'),
(865, 'User 865', 'ZVI6357873', '2002-11-10', '7024844173', 'user865@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(866, 'User 866', 'MOH4225096', '1974-03-24', '2747028819', 'user866@example.com'),
(867, 'User 867', 'IGU3502747', '1920-12-11', '4816973574', 'user867@example.com'),
(868, 'User 868', 'XSJ5454826', '1983-03-02', '9752276005', 'user868@example.com'),
(869, 'User 869', 'IEO1629699', '1988-01-13', '9606767469', 'user869@example.com'),
(870, 'User 870', 'NQD8725859', '2003-11-09', '8336820381', 'user870@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(871, 'User 871', 'YEM7978400', '1985-09-11', '4187523345', 'user871@example.com'),
(872, 'User 872', 'YYF2319739', '1969-05-16', '9057465908', 'user872@example.com'),
(873, 'User 873', 'ZPB7142283', '1978-07-22', '7858091498', 'user873@example.com'),
(874, 'User 874', 'BQS0422228', '1916-07-09', '4658833036', 'user874@example.com'),
(875, 'User 875', 'AUQ3632376', '1941-06-07', '4125263619', 'user875@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(876, 'User 876', 'NDM1482348', '1913-07-24', '4217404474', 'user876@example.com'),
(877, 'User 877', 'UMW8151086', '1902-06-06', '9195789318', 'user877@example.com'),
(878, 'User 878', 'GTF8152540', '1919-03-28', '4754627855', 'user878@example.com'),
(879, 'User 879', 'OBG2829838', '1992-03-17', '8304988950', 'user879@example.com'),
(880, 'User 880', 'HKD4792468', '1997-02-01', '1274251191', 'user880@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(881, 'User 881', 'EFL6253123', '1921-03-15', '7369032932', 'user881@example.com'),
(882, 'User 882', 'TIF3561614', '1910-06-06', '6171428714', 'user882@example.com'),
(883, 'User 883', 'GUR5113700', '1949-03-05', '3142584156', 'user883@example.com'),
(884, 'User 884', 'TCG0804595', '1923-02-19', '4177692750', 'user884@example.com'),
(885, 'User 885', 'MDX9411777', '1963-08-26', '6847129628', 'user885@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(886, 'User 886', 'LOQ7796739', '1965-02-09', '8856019452', 'user886@example.com'),
(887, 'User 887', 'KSG2939712', '1968-11-17', '5678913037', 'user887@example.com'),
(888, 'User 888', 'JIH8250591', '1987-02-13', '3148544172', 'user888@example.com'),
(889, 'User 889', 'VOD3966456', '1921-03-23', '6005751333', 'user889@example.com'),
(890, 'User 890', 'GSZ1086167', '1996-10-10', '8686857054', 'user890@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(891, 'User 891', 'SGG1227354', '1941-12-01', '3519572847', 'user891@example.com'),
(892, 'User 892', 'MQH9098367', '1928-04-06', '2177002091', 'user892@example.com'),
(893, 'User 893', 'TXM7348797', '1983-01-13', '7893573515', 'user893@example.com'),
(894, 'User 894', 'GDT8050139', '1923-10-14', '7226153823', 'user894@example.com'),
(895, 'User 895', 'FEI8307549', '1909-07-28', '0919361547', 'user895@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(896, 'User 896', 'RKH0060156', '1902-10-02', '9394375048', 'user896@example.com'),
(897, 'User 897', 'CUH4678922', '1932-02-21', '7321850376', 'user897@example.com'),
(898, 'User 898', 'NDY4847862', '1973-03-05', '7956928719', 'user898@example.com'),
(899, 'User 899', 'AYP3230207', '1936-02-26', '3438788912', 'user899@example.com'),
(900, 'User 900', 'DZY9403203', '1915-02-05', '9253956902', 'user900@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(901, 'User 901', 'TBX8902246', '1996-11-23', '1949920680', 'user901@example.com'),
(902, 'User 902', 'AXY9792264', '1936-01-22', '5286304006', 'user902@example.com'),
(903, 'User 903', 'KFF8489284', '1922-07-28', '3140423242', 'user903@example.com'),
(904, 'User 904', 'OFL1978888', '1907-11-29', '2716876706', 'user904@example.com'),
(905, 'User 905', 'GRV8715184', '1989-02-23', '0329671275', 'user905@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(906, 'User 906', 'TYG5736020', '1928-09-23', '3124857870', 'user906@example.com'),
(907, 'User 907', 'CAP3071762', '1952-02-27', '1049420223', 'user907@example.com'),
(908, 'User 908', 'JTD1141191', '2003-04-02', '6310057020', 'user908@example.com'),
(909, 'User 909', 'IHY2945200', '1907-05-21', '8681151740', 'user909@example.com'),
(910, 'User 910', 'YRF5090953', '1955-12-22', '5384800590', 'user910@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(911, 'User 911', 'TMG3654782', '1992-11-29', '8835152114', 'user911@example.com'),
(912, 'User 912', 'GSF8450012', '1993-04-17', '0609082869', 'user912@example.com'),
(913, 'User 913', 'TOE7189802', '1965-08-14', '8636111129', 'user913@example.com'),
(914, 'User 914', 'ZUK8461345', '1992-09-29', '1772793657', 'user914@example.com'),
(915, 'User 915', 'LED9327803', '1987-05-20', '4211714921', 'user915@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(916, 'User 916', 'BJT1548291', '1936-03-04', '4596346052', 'user916@example.com'),
(917, 'User 917', 'KWO1781966', '1931-05-24', '1282807781', 'user917@example.com'),
(918, 'User 918', 'HIW4723132', '1926-08-13', '4637899809', 'user918@example.com'),
(919, 'User 919', 'KJR7757484', '1933-04-23', '6704883307', 'user919@example.com'),
(920, 'User 920', 'DCP5919859', '2003-11-21', '8774161515', 'user920@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(921, 'User 921', 'SCT4518059', '1937-02-21', '5236840559', 'user921@example.com'),
(922, 'User 922', 'RKX6322110', '1984-08-05', '3319638834', 'user922@example.com'),
(923, 'User 923', 'HXA9521808', '1979-12-03', '4997864620', 'user923@example.com'),
(924, 'User 924', 'FSS6933312', '1927-12-27', '9513910598', 'user924@example.com'),
(925, 'User 925', 'EZJ5910469', '2003-11-19', '3534183193', 'user925@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(926, 'User 926', 'WZE2534425', '1996-10-07', '4096180682', 'user926@example.com'),
(927, 'User 927', 'CCT8957642', '1923-07-29', '0779176907', 'user927@example.com'),
(928, 'User 928', 'WFF0815260', '1983-06-22', '4238093477', 'user928@example.com'),
(929, 'User 929', 'AUQ8727649', '1992-12-01', '2797998370', 'user929@example.com'),
(930, 'User 930', 'LKM7922056', '1927-07-27', '3306973254', 'user930@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(931, 'User 931', 'LYR5130095', '1996-04-18', '0696488819', 'user931@example.com'),
(932, 'User 932', 'KBE0360697', '1948-02-14', '3009564290', 'user932@example.com'),
(933, 'User 933', 'FGH1799145', '2004-09-07', '7849595333', 'user933@example.com'),
(934, 'User 934', 'KDT3556541', '1996-03-10', '3813900508', 'user934@example.com'),
(935, 'User 935', 'SBT1128125', '1955-06-03', '9317263811', 'user935@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(936, 'User 936', 'GBP3813553', '1937-09-30', '8581901348', 'user936@example.com'),
(937, 'User 937', 'RPV6148502', '2005-04-20', '6358565890', 'user937@example.com'),
(938, 'User 938', 'VBT1062602', '1941-12-22', '1412528805', 'user938@example.com'),
(939, 'User 939', 'GCG4324389', '1933-10-24', '1774432543', 'user939@example.com'),
(940, 'User 940', 'EGM6146474', '1931-06-11', '1211220980', 'user940@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(941, 'User 941', 'ICH6980781', '1976-08-22', '3457412527', 'user941@example.com'),
(942, 'User 942', 'KQG5546779', '1930-03-06', '9200310408', 'user942@example.com'),
(943, 'User 943', 'XTA8010545', '1945-09-14', '8452863372', 'user943@example.com'),
(944, 'User 944', 'FDD3695815', '1982-05-26', '3846500905', 'user944@example.com'),
(945, 'User 945', 'KPK1114454', '1994-11-14', '0641231354', 'user945@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(946, 'User 946', 'EMB5680383', '1940-12-06', '6312455311', 'user946@example.com'),
(947, 'User 947', 'JMH5391754', '2003-10-30', '9526890861', 'user947@example.com'),
(948, 'User 948', 'DZS7585097', '1901-10-26', '9821734975', 'user948@example.com'),
(949, 'User 949', 'BRH7362955', '1936-08-25', '9155624243', 'user949@example.com'),
(950, 'User 950', 'VLV6512323', '1988-08-16', '8220795424', 'user950@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(951, 'User 951', 'FLX3295730', '1946-09-13', '3516375735', 'user951@example.com'),
(952, 'User 952', 'OVM3206691', '1965-10-15', '4593895271', 'user952@example.com'),
(953, 'User 953', 'GJT6468541', '2000-03-21', '1106233562', 'user953@example.com'),
(954, 'User 954', 'PZL7880938', '1945-07-09', '5965770586', 'user954@example.com'),
(955, 'User 955', 'ACI3507705', '1936-05-10', '7435915026', 'user955@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(956, 'User 956', 'RNL5911569', '1930-10-18', '8245876252', 'user956@example.com'),
(957, 'User 957', 'QMR8611266', '1949-02-04', '7288275875', 'user957@example.com'),
(958, 'User 958', 'XTX8967817', '1940-12-10', '3987638436', 'user958@example.com'),
(959, 'User 959', 'HQW6507291', '1985-12-29', '2312895237', 'user959@example.com'),
(960, 'User 960', 'EYU5437912', '1948-09-20', '9019317465', 'user960@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(961, 'User 961', 'UNN3318682', '2004-04-23', '0812978447', 'user961@example.com'),
(962, 'User 962', 'HMP1521128', '1916-11-14', '7988115215', 'user962@example.com'),
(963, 'User 963', 'NHN2823952', '1993-05-14', '6239596173', 'user963@example.com'),
(964, 'User 964', 'NIY8936252', '1900-10-11', '8027511294', 'user964@example.com'),
(965, 'User 965', 'ZMT1440757', '1948-11-28', '5854841683', 'user965@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(966, 'User 966', 'PAR0012769', '1946-10-16', '5334105733', 'user966@example.com'),
(967, 'User 967', 'SNO8853965', '1994-11-03', '3782984053', 'user967@example.com'),
(968, 'User 968', 'KXJ8922634', '1951-07-28', '0744078237', 'user968@example.com'),
(969, 'User 969', 'PTN4647219', '1983-07-17', '1837508155', 'user969@example.com'),
(970, 'User 970', 'LPC6408618', '1964-06-15', '2182364437', 'user970@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(971, 'User 971', 'OVB7852781', '1919-11-12', '5576564808', 'user971@example.com'),
(972, 'User 972', 'AKT2005520', '1995-01-16', '9675935997', 'user972@example.com'),
(973, 'User 973', 'GDY0839614', '1994-03-25', '8391577521', 'user973@example.com'),
(974, 'User 974', 'TCW6253022', '1946-09-01', '4505507663', 'user974@example.com'),
(975, 'User 975', 'EVZ9457372', '1986-07-12', '2207506666', 'user975@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(976, 'User 976', 'UQD7357803', '1965-01-03', '3633387447', 'user976@example.com'),
(977, 'User 977', 'WAD8156695', '1959-08-17', '3197165975', 'user977@example.com'),
(978, 'User 978', 'BME6916790', '1934-11-10', '8369603972', 'user978@example.com'),
(979, 'User 979', 'SEV7990983', '1963-12-14', '8812884586', 'user979@example.com'),
(980, 'User 980', 'CBG2470192', '1987-08-26', '4968474908', 'user980@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(981, 'User 981', 'JST5819926', '1921-12-29', '0054835045', 'user981@example.com'),
(982, 'User 982', 'YZT9529575', '1935-01-27', '3641138481', 'user982@example.com'),
(983, 'User 983', 'ZYG2738581', '1999-02-07', '3151863547', 'user983@example.com'),
(984, 'User 984', 'RQN6707037', '1901-04-13', '7243738030', 'user984@example.com'),
(985, 'User 985', 'IRM8949517', '1956-05-26', '4272010299', 'user985@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(986, 'User 986', 'EAH1801797', '1955-12-24', '5474625581', 'user986@example.com'),
(987, 'User 987', 'ZWP8219268', '2003-06-23', '4636288321', 'user987@example.com'),
(988, 'User 988', 'YRP1975519', '1966-08-04', '7451595076', 'user988@example.com'),
(989, 'User 989', 'ZBJ9627805', '1936-05-18', '4203328876', 'user989@example.com'),
(990, 'User 990', 'LQY1360181', '1998-02-05', '9046499859', 'user990@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(991, 'User 991', 'CMM4274018', '2000-10-18', '9286661541', 'user991@example.com'),
(992, 'User 992', 'QKV3392492', '1914-09-24', '4952346334', 'user992@example.com'),
(993, 'User 993', 'LKQ9812944', '1912-10-03', '4559140909', 'user993@example.com'),
(994, 'User 994', 'FUN7974035', '1914-08-16', '8186055447', 'user994@example.com'),
(995, 'User 995', 'DNN2768231', '1955-08-12', '0689737070', 'user995@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(996, 'User 996', 'RHJ9136182', '1924-10-27', '6259432251', 'user996@example.com'),
(997, 'User 997', 'UQP5093150', '2003-03-21', '8513622200', 'user997@example.com'),
(998, 'User 998', 'XAK8752346', '1966-11-06', '6105332845', 'user998@example.com'),
(999, 'User 999', 'HAI1341411', '1908-06-09', '6318231886', 'user999@example.com'),
(1000, 'User 1000', 'COX3291568', '1941-01-30', '8152282311', 'user1000@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1001, 'User 1001', 'EDQ9120081', '1911-05-06', '1547617388', 'user1001@example.com'),
(1002, 'User 1002', 'LRA0271194', '1959-03-08', '2865546720', 'user1002@example.com'),
(1003, 'User 1003', 'ZQA1847765', '1915-11-29', '3832142489', 'user1003@example.com'),
(1004, 'User 1004', 'ITX9958065', '1990-02-10', '1337635411', 'user1004@example.com'),
(1005, 'User 1005', 'AQG8571911', '1975-11-20', '3212624712', 'user1005@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1006, 'User 1006', 'HDV4801235', '1959-07-08', '5088794392', 'user1006@example.com'),
(1007, 'User 1007', 'ZNU7221904', '1990-08-28', '9017961558', 'user1007@example.com'),
(1008, 'User 1008', 'VLS9077010', '1957-02-06', '4720497935', 'user1008@example.com'),
(1009, 'User 1009', 'YMU6898284', '1901-10-27', '7001433255', 'user1009@example.com'),
(1010, 'User 1010', 'XQI9509590', '1952-03-24', '9640529922', 'user1010@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1011, 'User 1011', 'FGO3820234', '1912-01-29', '9425674096', 'user1011@example.com'),
(1012, 'User 1012', 'BWB0046874', '1958-05-11', '9688193899', 'user1012@example.com'),
(1013, 'User 1013', 'GWR6942549', '1930-06-06', '6481142517', 'user1013@example.com'),
(1014, 'User 1014', 'HOH7012088', '2003-12-28', '5316471730', 'user1014@example.com'),
(1015, 'User 1015', 'LFS4158259', '2002-09-18', '8560078370', 'user1015@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1016, 'User 1016', 'PQM6141294', '1962-04-25', '6388464994', 'user1016@example.com'),
(1017, 'User 1017', 'TOA4132754', '1974-06-24', '8215044316', 'user1017@example.com'),
(1018, 'User 1018', 'XNP7340893', '1907-03-04', '5619389761', 'user1018@example.com'),
(1019, 'User 1019', 'YYC8544116', '1958-01-11', '7842625713', 'user1019@example.com'),
(1020, 'User 1020', 'ARH9935772', '1910-11-30', '2168880847', 'user1020@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1021, 'User 1021', 'QSJ4690738', '1976-07-14', '4401057902', 'user1021@example.com'),
(1022, 'User 1022', 'KZC3015728', '1978-02-19', '2927050443', 'user1022@example.com'),
(1023, 'User 1023', 'HGX6696042', '1946-12-08', '4340862322', 'user1023@example.com'),
(1024, 'User 1024', 'WPQ9857848', '1944-12-16', '3718036760', 'user1024@example.com'),
(1025, 'User 1025', 'MXY1901824', '1930-08-11', '6623133608', 'user1025@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1026, 'User 1026', 'FWC8504269', '1941-07-30', '1615837564', 'user1026@example.com'),
(1027, 'User 1027', 'LVD3358365', '1957-10-05', '4375716663', 'user1027@example.com'),
(1028, 'User 1028', 'NNH1267156', '1946-07-06', '6600487567', 'user1028@example.com'),
(1029, 'User 1029', 'IGD6008200', '1938-09-18', '5691015871', 'user1029@example.com'),
(1030, 'User 1030', 'BZJ9387413', '1911-08-09', '3424581993', 'user1030@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1031, 'User 1031', 'IEV8059972', '1956-07-10', '3250297698', 'user1031@example.com'),
(1032, 'User 1032', 'EEM0686455', '1906-02-16', '9978776721', 'user1032@example.com'),
(1033, 'User 1033', 'OZG8398512', '1903-07-21', '4758079537', 'user1033@example.com'),
(1034, 'User 1034', 'JNU0800076', '1990-11-10', '2226058462', 'user1034@example.com'),
(1035, 'User 1035', 'LHY8564968', '1966-02-14', '1374788306', 'user1035@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1036, 'User 1036', 'JUC6687429', '1999-05-16', '0374859290', 'user1036@example.com'),
(1037, 'User 1037', 'CHY4664453', '1979-11-02', '1038430478', 'user1037@example.com'),
(1038, 'User 1038', 'VSN1361293', '1993-02-13', '5766867859', 'user1038@example.com'),
(1039, 'User 1039', 'NUV2068422', '1967-06-15', '0288341621', 'user1039@example.com'),
(1040, 'User 1040', 'KEI5558797', '1925-04-08', '2026838248', 'user1040@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1041, 'User 1041', 'WCZ5142875', '1985-04-14', '6421016353', 'user1041@example.com'),
(1042, 'User 1042', 'KCE3859489', '2004-05-21', '6716541635', 'user1042@example.com'),
(1043, 'User 1043', 'HPR3892644', '1992-01-17', '9741270681', 'user1043@example.com'),
(1044, 'User 1044', 'QZH5149742', '1922-10-18', '6613695053', 'user1044@example.com'),
(1045, 'User 1045', 'GVB3045873', '1976-10-03', '5620692630', 'user1045@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1046, 'User 1046', 'MHA7527163', '2000-08-15', '1957714622', 'user1046@example.com'),
(1047, 'User 1047', 'CXV3929208', '1947-01-29', '7936117073', 'user1047@example.com'),
(1048, 'User 1048', 'AHQ2117306', '1934-08-29', '7343125732', 'user1048@example.com'),
(1049, 'User 1049', 'XOV0132536', '1933-04-18', '4100854020', 'user1049@example.com'),
(1050, 'User 1050', 'YZE7305790', '2003-01-16', '0068535994', 'user1050@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1051, 'User 1051', 'XUE6607862', '1970-02-06', '2454546291', 'user1051@example.com'),
(1052, 'User 1052', 'LYL2889583', '1907-04-27', '2552265241', 'user1052@example.com'),
(1053, 'User 1053', 'QQT6419392', '1930-11-30', '9793706239', 'user1053@example.com'),
(1054, 'User 1054', 'UZU8963863', '1978-06-10', '4491986133', 'user1054@example.com'),
(1055, 'User 1055', 'MKA1270480', '1932-09-10', '6750343760', 'user1055@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1056, 'User 1056', 'EPP0685456', '1968-07-05', '8725098817', 'user1056@example.com'),
(1057, 'User 1057', 'CPW0148744', '1954-06-25', '1286165643', 'user1057@example.com'),
(1058, 'User 1058', 'RXC3949540', '1900-12-02', '4490677298', 'user1058@example.com'),
(1059, 'User 1059', 'CYB3874440', '1935-12-10', '4174571462', 'user1059@example.com'),
(1060, 'User 1060', 'LJE8903300', '1965-05-26', '6080305296', 'user1060@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1061, 'User 1061', 'RAO0449933', '1989-12-26', '1531627750', 'user1061@example.com'),
(1062, 'User 1062', 'XLI6650146', '1974-01-30', '8781272009', 'user1062@example.com'),
(1063, 'User 1063', 'DPD2477757', '1961-07-09', '4647314819', 'user1063@example.com'),
(1064, 'User 1064', 'EIN5859434', '1942-12-08', '6042642653', 'user1064@example.com'),
(1065, 'User 1065', 'DGY3731013', '1951-05-19', '5704906611', 'user1065@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1066, 'User 1066', 'TZN2618235', '1908-05-27', '6566801017', 'user1066@example.com'),
(1067, 'User 1067', 'JOH2006195', '1985-01-09', '7719586861', 'user1067@example.com'),
(1068, 'User 1068', 'KRC1503963', '1982-05-10', '7545995953', 'user1068@example.com'),
(1069, 'User 1069', 'JUL5541269', '1908-05-23', '0524349831', 'user1069@example.com'),
(1070, 'User 1070', 'AEN1861530', '1982-01-13', '9727108931', 'user1070@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1071, 'User 1071', 'DLQ2900649', '1948-02-15', '6169905856', 'user1071@example.com'),
(1072, 'User 1072', 'BCZ9928884', '1969-03-11', '9070036922', 'user1072@example.com'),
(1073, 'User 1073', 'AYQ3661379', '1939-04-24', '5641177594', 'user1073@example.com'),
(1074, 'User 1074', 'KDI0521565', '1938-03-17', '0965819091', 'user1074@example.com'),
(1075, 'User 1075', 'EGQ9072182', '1984-08-08', '3669846293', 'user1075@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1076, 'User 1076', 'DQI4396901', '1948-11-02', '3707272491', 'user1076@example.com'),
(1077, 'User 1077', 'GIZ4818623', '1986-03-18', '3683198793', 'user1077@example.com'),
(1078, 'User 1078', 'OJA1611771', '1981-06-05', '3286344697', 'user1078@example.com'),
(1079, 'User 1079', 'MLP5002237', '2003-12-15', '4564181784', 'user1079@example.com'),
(1080, 'User 1080', 'AGV7037324', '1923-12-22', '6062953304', 'user1080@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1081, 'User 1081', 'MWT4381285', '1940-07-03', '8888699581', 'user1081@example.com'),
(1082, 'User 1082', 'TEF0076460', '1990-06-12', '5113584655', 'user1082@example.com'),
(1083, 'User 1083', 'HJO6485380', '1949-10-22', '6059290068', 'user1083@example.com'),
(1084, 'User 1084', 'JBB9743273', '1983-01-15', '2660589396', 'user1084@example.com'),
(1085, 'User 1085', 'APL5759996', '1980-11-22', '4446920070', 'user1085@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1086, 'User 1086', 'JER9461684', '1916-11-25', '3582661100', 'user1086@example.com'),
(1087, 'User 1087', 'OEY4425890', '1941-02-10', '9306666601', 'user1087@example.com'),
(1088, 'User 1088', 'NRS1327321', '1958-02-23', '6643106794', 'user1088@example.com'),
(1089, 'User 1089', 'CCZ3893728', '2002-12-23', '2116374616', 'user1089@example.com'),
(1090, 'User 1090', 'BRC4754360', '2003-01-30', '1511649807', 'user1090@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1091, 'User 1091', 'PZL0758188', '1962-09-10', '9810156291', 'user1091@example.com'),
(1092, 'User 1092', 'CWS1769586', '1980-12-14', '9571354732', 'user1092@example.com'),
(1093, 'User 1093', 'LLR1392102', '1965-06-18', '0112834638', 'user1093@example.com'),
(1094, 'User 1094', 'WJX8378017', '1994-09-15', '7567777311', 'user1094@example.com'),
(1095, 'User 1095', 'FTF7312156', '1981-10-07', '3134794481', 'user1095@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1096, 'User 1096', 'BBB1788977', '1920-04-19', '1416701506', 'user1096@example.com'),
(1097, 'User 1097', 'IZA9728437', '1977-09-01', '7019037272', 'user1097@example.com'),
(1098, 'User 1098', 'VGU6806806', '1957-07-11', '4330835908', 'user1098@example.com'),
(1099, 'User 1099', 'ZGZ8669281', '1921-06-25', '8041745804', 'user1099@example.com'),
(1100, 'User 1100', 'LWT7561720', '1957-04-19', '3254615686', 'user1100@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1101, 'User 1101', 'HEY5824473', '1947-08-19', '0612237159', 'user1101@example.com'),
(1102, 'User 1102', 'JMW5833730', '1954-03-19', '7473909667', 'user1102@example.com'),
(1103, 'User 1103', 'LZW4098772', '1972-05-23', '9065565923', 'user1103@example.com'),
(1104, 'User 1104', 'CUV4861403', '1924-12-24', '3278719307', 'user1104@example.com'),
(1105, 'User 1105', 'PEN9809344', '1990-11-25', '4110953220', 'user1105@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1106, 'User 1106', 'AHB7820069', '1947-09-25', '7371596556', 'user1106@example.com'),
(1107, 'User 1107', 'EFY2388486', '1946-12-07', '1586611768', 'user1107@example.com'),
(1108, 'User 1108', 'PJA2557839', '1954-02-21', '7008915423', 'user1108@example.com'),
(1109, 'User 1109', 'QYY0594983', '1919-11-14', '7826022712', 'user1109@example.com'),
(1110, 'User 1110', 'SGB7906889', '1953-02-16', '1537482791', 'user1110@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1111, 'User 1111', 'HMU3652709', '1953-04-30', '0325093740', 'user1111@example.com'),
(1112, 'User 1112', 'BJD7335835', '1925-05-21', '0129258738', 'user1112@example.com'),
(1113, 'User 1113', 'LEE2681340', '1950-12-18', '3258479175', 'user1113@example.com'),
(1114, 'User 1114', 'OAB1182683', '1970-01-11', '5610637898', 'user1114@example.com'),
(1115, 'User 1115', 'YIX1097799', '1957-01-30', '6984595383', 'user1115@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1116, 'User 1116', 'LCL3963355', '1967-01-15', '6720931395', 'user1116@example.com'),
(1117, 'User 1117', 'GDI0247756', '1980-10-07', '0757632245', 'user1117@example.com'),
(1118, 'User 1118', 'NIB2735947', '1929-03-03', '9366020600', 'user1118@example.com'),
(1119, 'User 1119', 'NVQ2606165', '2001-02-02', '8596417573', 'user1119@example.com'),
(1120, 'User 1120', 'WWE5475866', '1918-01-22', '4731203589', 'user1120@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1121, 'User 1121', 'UYQ2827690', '1917-05-18', '8850477287', 'user1121@example.com'),
(1122, 'User 1122', 'ROX8756294', '1993-10-10', '9292383738', 'user1122@example.com'),
(1123, 'User 1123', 'JPP2955681', '1954-12-09', '4757233381', 'user1123@example.com'),
(1124, 'User 1124', 'JAH6627937', '1990-10-29', '8700111638', 'user1124@example.com'),
(1125, 'User 1125', 'ARO6031821', '1942-10-15', '9897393245', 'user1125@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1126, 'User 1126', 'LME5480993', '1923-02-17', '3161673365', 'user1126@example.com'),
(1127, 'User 1127', 'IAE4383831', '1983-10-09', '1902419094', 'user1127@example.com'),
(1128, 'User 1128', 'BQM2536721', '1954-09-29', '2394265515', 'user1128@example.com'),
(1129, 'User 1129', 'FYT1666866', '1951-09-20', '7731141122', 'user1129@example.com'),
(1130, 'User 1130', 'LYU9618275', '1927-08-18', '3435100664', 'user1130@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1131, 'User 1131', 'NBJ1378916', '1951-08-24', '8292349836', 'user1131@example.com'),
(1132, 'User 1132', 'AZM8578268', '1954-01-11', '7014137015', 'user1132@example.com'),
(1133, 'User 1133', 'ABS5656205', '1964-04-19', '1359099124', 'user1133@example.com'),
(1134, 'User 1134', 'XAB7906675', '1907-05-09', '5026482143', 'user1134@example.com'),
(1135, 'User 1135', 'NLK9336792', '1959-12-01', '5802884058', 'user1135@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1136, 'User 1136', 'MHT3056851', '1949-04-21', '4120422976', 'user1136@example.com'),
(1137, 'User 1137', 'GUV9502732', '1936-05-07', '4260077704', 'user1137@example.com'),
(1138, 'User 1138', 'PPK3905026', '1952-02-02', '4531478340', 'user1138@example.com'),
(1139, 'User 1139', 'JGR5456682', '1984-07-20', '9755392904', 'user1139@example.com'),
(1140, 'User 1140', 'NHM3699177', '1901-02-24', '2217265234', 'user1140@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1141, 'User 1141', 'UNZ0646691', '1962-03-12', '1306925009', 'user1141@example.com'),
(1142, 'User 1142', 'JAS9147334', '1984-03-08', '9233177471', 'user1142@example.com'),
(1143, 'User 1143', 'XZZ0904685', '1980-03-28', '3663195611', 'user1143@example.com'),
(1144, 'User 1144', 'ZQJ3919320', '1908-03-02', '4790674507', 'user1144@example.com'),
(1145, 'User 1145', 'YQM5124122', '1965-08-23', '4659230177', 'user1145@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1146, 'User 1146', 'AEC0936339', '1965-06-16', '7507482931', 'user1146@example.com'),
(1147, 'User 1147', 'DGD6936440', '1959-04-14', '2830697932', 'user1147@example.com'),
(1148, 'User 1148', 'GGH4541373', '1934-09-24', '3141470570', 'user1148@example.com'),
(1149, 'User 1149', 'DAQ3868273', '2000-06-19', '6792021385', 'user1149@example.com'),
(1150, 'User 1150', 'BGK8336871', '1934-11-09', '3802863484', 'user1150@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1151, 'User 1151', 'ZQV6364681', '1993-05-26', '4318800257', 'user1151@example.com'),
(1152, 'User 1152', 'VAK3820403', '1988-01-27', '7207944230', 'user1152@example.com'),
(1153, 'User 1153', 'KMM3345619', '2004-06-30', '3277959259', 'user1153@example.com'),
(1154, 'User 1154', 'XGR4744217', '1947-11-11', '5547410832', 'user1154@example.com'),
(1155, 'User 1155', 'RKJ3935861', '1974-06-13', '4635899404', 'user1155@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1156, 'User 1156', 'CDS5008011', '1968-02-06', '0549330513', 'user1156@example.com'),
(1157, 'User 1157', 'ENO6237385', '1947-09-20', '9534477931', 'user1157@example.com'),
(1158, 'User 1158', 'VKZ6791302', '1921-06-20', '7792180127', 'user1158@example.com'),
(1159, 'User 1159', 'RUO6737886', '2004-11-09', '3550472566', 'user1159@example.com'),
(1160, 'User 1160', 'XRO6972285', '1906-04-28', '0410672299', 'user1160@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1161, 'User 1161', 'JDN6329079', '1956-04-21', '7615753157', 'user1161@example.com'),
(1162, 'User 1162', 'AYM4518563', '1986-09-23', '6288924037', 'user1162@example.com'),
(1163, 'User 1163', 'SAR7038915', '1913-05-22', '1650701382', 'user1163@example.com'),
(1164, 'User 1164', 'HFA2455725', '1962-03-27', '3382365376', 'user1164@example.com'),
(1165, 'User 1165', 'RRZ3446230', '1992-02-09', '0368229307', 'user1165@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1166, 'User 1166', 'FID9284857', '1981-07-06', '9187008538', 'user1166@example.com'),
(1167, 'User 1167', 'YJI2606974', '1910-10-18', '5633530947', 'user1167@example.com'),
(1168, 'User 1168', 'ATE9568377', '1917-02-19', '2165570190', 'user1168@example.com'),
(1169, 'User 1169', 'BCX4847591', '1953-05-03', '6691803008', 'user1169@example.com'),
(1170, 'User 1170', 'PRW9495103', '2005-05-26', '4423431359', 'user1170@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1171, 'User 1171', 'QBT3502755', '1915-04-18', '0740778332', 'user1171@example.com'),
(1172, 'User 1172', 'WQU7359033', '1924-11-23', '1647062930', 'user1172@example.com'),
(1173, 'User 1173', 'FCN9477717', '1917-08-28', '8667569498', 'user1173@example.com'),
(1174, 'User 1174', 'RYX3181032', '1966-11-08', '5196141410', 'user1174@example.com'),
(1175, 'User 1175', 'YPW4198631', '1933-04-18', '0095199683', 'user1175@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1176, 'User 1176', 'AVN5690111', '1904-05-01', '9049630142', 'user1176@example.com'),
(1177, 'User 1177', 'AEG8130489', '1964-01-19', '5062452011', 'user1177@example.com'),
(1178, 'User 1178', 'JQX7519739', '1907-08-16', '9992998122', 'user1178@example.com'),
(1179, 'User 1179', 'ZGJ2601304', '1944-08-10', '5760887491', 'user1179@example.com'),
(1180, 'User 1180', 'GGB8271915', '1935-12-27', '7524772304', 'user1180@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1181, 'User 1181', 'SXM1852377', '1915-06-19', '6376056001', 'user1181@example.com'),
(1182, 'User 1182', 'BIK2627031', '1935-01-13', '0513952997', 'user1182@example.com'),
(1183, 'User 1183', 'RKV5130464', '1949-07-22', '2258434841', 'user1183@example.com'),
(1184, 'User 1184', 'WQZ4758991', '1944-06-06', '5079822990', 'user1184@example.com'),
(1185, 'User 1185', 'ELJ2431510', '1974-02-21', '7341756630', 'user1185@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1186, 'User 1186', 'VUJ0497045', '1973-12-19', '1393832725', 'user1186@example.com'),
(1187, 'User 1187', 'DWS8141244', '1968-11-24', '2319440784', 'user1187@example.com'),
(1188, 'User 1188', 'HWM2848683', '1934-08-02', '8454271639', 'user1188@example.com'),
(1189, 'User 1189', 'GPQ2361644', '1939-05-27', '5055459048', 'user1189@example.com'),
(1190, 'User 1190', 'LRV1390939', '1918-05-11', '1605742469', 'user1190@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1191, 'User 1191', 'PKO2162256', '1942-09-22', '4433422246', 'user1191@example.com'),
(1192, 'User 1192', 'GJK4372747', '1936-11-15', '7911562513', 'user1192@example.com'),
(1193, 'User 1193', 'YYX6992490', '1977-06-06', '6017607562', 'user1193@example.com'),
(1194, 'User 1194', 'JGM9006045', '1999-12-12', '7387111944', 'user1194@example.com'),
(1195, 'User 1195', 'GCF8700354', '1930-08-02', '6364763651', 'user1195@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1196, 'User 1196', 'VTZ5983605', '1946-07-21', '8220485165', 'user1196@example.com'),
(1197, 'User 1197', 'INP5259161', '1952-09-05', '5010860272', 'user1197@example.com'),
(1198, 'User 1198', 'EYQ0926194', '1942-03-01', '5368550586', 'user1198@example.com'),
(1199, 'User 1199', 'BAH2445971', '1918-07-07', '0926135150', 'user1199@example.com'),
(1200, 'User 1200', 'ACG0784462', '1979-08-18', '3107390217', 'user1200@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1201, 'User 1201', 'OWE4702696', '1953-08-08', '6215735416', 'user1201@example.com'),
(1202, 'User 1202', 'YJG1506249', '1947-04-28', '2761255265', 'user1202@example.com'),
(1203, 'User 1203', 'PTX7289970', '1961-11-29', '6034109779', 'user1203@example.com'),
(1204, 'User 1204', 'WSA7539366', '1939-03-30', '6504575647', 'user1204@example.com'),
(1205, 'User 1205', 'JDA4795016', '1962-03-28', '9204343543', 'user1205@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1206, 'User 1206', 'HYE0546759', '1996-01-21', '2578979305', 'user1206@example.com'),
(1207, 'User 1207', 'XHB4826481', '1936-03-17', '6893199176', 'user1207@example.com'),
(1208, 'User 1208', 'NTW8757541', '1969-12-06', '6840218977', 'user1208@example.com'),
(1209, 'User 1209', 'RDQ8757672', '1911-10-28', '0867211817', 'user1209@example.com'),
(1210, 'User 1210', 'ASD7948157', '1901-07-13', '6577128715', 'user1210@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1211, 'User 1211', 'LMZ9515655', '1942-08-19', '3625757575', 'user1211@example.com'),
(1212, 'User 1212', 'UKI8178646', '1998-11-15', '2304658382', 'user1212@example.com'),
(1213, 'User 1213', 'MKP2682289', '1959-05-30', '5349648714', 'user1213@example.com'),
(1214, 'User 1214', 'HRR5775662', '1959-08-11', '0329417460', 'user1214@example.com'),
(1215, 'User 1215', 'MDG9070905', '1915-02-17', '3471665943', 'user1215@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1216, 'User 1216', 'PXC2697216', '1906-04-02', '4976244741', 'user1216@example.com'),
(1217, 'User 1217', 'WUK3751105', '1977-03-30', '2269192460', 'user1217@example.com'),
(1218, 'User 1218', 'CPM6554513', '1958-08-24', '8253446868', 'user1218@example.com'),
(1219, 'User 1219', 'NKS3359700', '1966-05-24', '5218494048', 'user1219@example.com'),
(1220, 'User 1220', 'DYQ2299044', '1965-07-27', '9594514067', 'user1220@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1221, 'User 1221', 'OCO5608859', '1900-03-20', '6223376438', 'user1221@example.com'),
(1222, 'User 1222', 'OCV1123861', '1930-11-03', '1504013232', 'user1222@example.com'),
(1223, 'User 1223', 'AXA9187337', '1983-05-29', '0105407266', 'user1223@example.com'),
(1224, 'User 1224', 'NBM0442299', '1995-11-14', '9634118546', 'user1224@example.com'),
(1225, 'User 1225', 'BAG7126875', '1908-08-20', '9274827858', 'user1225@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1226, 'User 1226', 'NPZ6472554', '1963-01-08', '1196360130', 'user1226@example.com'),
(1227, 'User 1227', 'HHY5447492', '1968-12-06', '9508031330', 'user1227@example.com'),
(1228, 'User 1228', 'BTS4438997', '1985-04-13', '1766717280', 'user1228@example.com'),
(1229, 'User 1229', 'ZYZ5186070', '1983-09-24', '4082195143', 'user1229@example.com'),
(1230, 'User 1230', 'YYY2022362', '1944-01-27', '4689286825', 'user1230@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1231, 'User 1231', 'JOU9990608', '1910-05-17', '4029811153', 'user1231@example.com'),
(1232, 'User 1232', 'QJF0587213', '1930-11-27', '5063457957', 'user1232@example.com'),
(1233, 'User 1233', 'YPX1833831', '1948-03-21', '3921842574', 'user1233@example.com'),
(1234, 'User 1234', 'QFG2756695', '1905-08-23', '7465962158', 'user1234@example.com'),
(1235, 'User 1235', 'QLC5700070', '1981-08-11', '4451964137', 'user1235@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1236, 'User 1236', 'KWU5737048', '1919-10-20', '4433540933', 'user1236@example.com'),
(1237, 'User 1237', 'YMV4978746', '1935-12-19', '6971061518', 'user1237@example.com'),
(1238, 'User 1238', 'YHR8161311', '1992-04-02', '5757895124', 'user1238@example.com'),
(1239, 'User 1239', 'GRM6848359', '1900-05-15', '3911626056', 'user1239@example.com'),
(1240, 'User 1240', 'KKD2626389', '1915-08-09', '0709087218', 'user1240@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1241, 'User 1241', 'QTO4571597', '1977-04-08', '3862979126', 'user1241@example.com'),
(1242, 'User 1242', 'PQG4187338', '1934-11-10', '3420076549', 'user1242@example.com'),
(1243, 'User 1243', 'MCZ5791911', '1932-08-13', '2915632098', 'user1243@example.com'),
(1244, 'User 1244', 'VPH8543491', '1929-10-04', '9368248154', 'user1244@example.com'),
(1245, 'User 1245', 'FCK8116972', '1951-03-18', '4300988759', 'user1245@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1246, 'User 1246', 'WHN5101510', '1954-12-14', '1875098065', 'user1246@example.com'),
(1247, 'User 1247', 'XVG4296548', '1920-05-10', '2223641640', 'user1247@example.com'),
(1248, 'User 1248', 'QPB9439908', '1946-06-19', '7070922817', 'user1248@example.com'),
(1249, 'User 1249', 'DPG5380902', '1982-05-03', '8712043567', 'user1249@example.com'),
(1250, 'User 1250', 'YXK5767262', '1942-01-11', '1115794556', 'user1250@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1251, 'User 1251', 'XIA7361612', '1931-08-22', '6115343728', 'user1251@example.com'),
(1252, 'User 1252', 'DPV0375417', '1922-07-25', '8044029740', 'user1252@example.com'),
(1253, 'User 1253', 'WSI8623329', '1933-08-15', '5894266857', 'user1253@example.com'),
(1254, 'User 1254', 'ADM7877871', '1931-01-04', '4143450346', 'user1254@example.com'),
(1255, 'User 1255', 'RAZ8837843', '1936-09-05', '1817633437', 'user1255@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1256, 'User 1256', 'GVR9850173', '1968-07-14', '1437333148', 'user1256@example.com'),
(1257, 'User 1257', 'YOQ9800934', '1962-04-12', '6924370639', 'user1257@example.com'),
(1258, 'User 1258', 'DHC1828602', '1958-10-10', '3812129466', 'user1258@example.com'),
(1259, 'User 1259', 'NAU4606014', '1985-08-28', '9256558191', 'user1259@example.com'),
(1260, 'User 1260', 'YMH3574092', '1930-04-02', '6118644188', 'user1260@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1261, 'User 1261', 'UPX0926336', '1916-07-03', '8543815650', 'user1261@example.com'),
(1262, 'User 1262', 'NEO0729639', '1970-07-20', '0846290613', 'user1262@example.com'),
(1263, 'User 1263', 'YNB5472418', '1932-11-22', '9021623628', 'user1263@example.com'),
(1264, 'User 1264', 'QCI2531015', '1983-09-18', '8616719210', 'user1264@example.com'),
(1265, 'User 1265', 'MJH2913436', '1919-08-24', '9452252771', 'user1265@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1266, 'User 1266', 'JMW1658507', '1975-07-13', '6875693393', 'user1266@example.com'),
(1267, 'User 1267', 'VIR5389360', '1968-05-05', '1931673485', 'user1267@example.com'),
(1268, 'User 1268', 'HZR4267101', '1962-06-03', '2898068029', 'user1268@example.com'),
(1269, 'User 1269', 'BEM2212520', '1999-11-14', '1908042307', 'user1269@example.com'),
(1270, 'User 1270', 'DQG2041137', '1939-01-07', '6306076424', 'user1270@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1271, 'User 1271', 'HXH4896352', '1940-02-17', '2762259805', 'user1271@example.com'),
(1272, 'User 1272', 'JQP8741422', '1930-05-04', '8336103472', 'user1272@example.com'),
(1273, 'User 1273', 'ZUK2990339', '1917-10-14', '1766298447', 'user1273@example.com'),
(1274, 'User 1274', 'MMO2980939', '1933-05-25', '8565450425', 'user1274@example.com'),
(1275, 'User 1275', 'FHC1287385', '1906-07-14', '5597226273', 'user1275@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1276, 'User 1276', 'OBG0694528', '1974-11-15', '0937587026', 'user1276@example.com'),
(1277, 'User 1277', 'BPN2202479', '1912-07-26', '5792265452', 'user1277@example.com'),
(1278, 'User 1278', 'GDQ7973717', '1906-07-27', '5598819541', 'user1278@example.com'),
(1279, 'User 1279', 'ORA1176382', '1960-01-05', '0448471717', 'user1279@example.com'),
(1280, 'User 1280', 'UNX9988025', '1912-01-22', '6250994913', 'user1280@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1281, 'User 1281', 'VIL8156597', '1990-07-08', '2604713827', 'user1281@example.com'),
(1282, 'User 1282', 'MOR5128656', '1985-04-04', '8522569770', 'user1282@example.com'),
(1283, 'User 1283', 'XRA9391911', '1960-06-19', '6576196035', 'user1283@example.com'),
(1284, 'User 1284', 'SAT9202028', '1954-04-17', '7093403890', 'user1284@example.com'),
(1285, 'User 1285', 'NTV0390894', '1924-09-28', '7607067429', 'user1285@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1286, 'User 1286', 'FKI7426778', '1989-10-20', '2858800262', 'user1286@example.com'),
(1287, 'User 1287', 'LPW2823140', '2001-01-21', '2955697507', 'user1287@example.com'),
(1288, 'User 1288', 'BRA3613341', '1983-04-09', '4324261793', 'user1288@example.com'),
(1289, 'User 1289', 'LPD0141437', '1945-04-29', '4883410108', 'user1289@example.com'),
(1290, 'User 1290', 'GPP3375030', '1912-06-15', '5175457425', 'user1290@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1291, 'User 1291', 'WHA5936055', '1953-06-24', '1681975192', 'user1291@example.com'),
(1292, 'User 1292', 'MUE6452638', '1944-04-16', '9457930269', 'user1292@example.com'),
(1293, 'User 1293', 'TBD8295698', '2002-10-15', '4035748842', 'user1293@example.com'),
(1294, 'User 1294', 'IVG7433766', '1963-10-26', '6904364805', 'user1294@example.com'),
(1295, 'User 1295', 'FSI2715980', '1940-03-19', '9898513223', 'user1295@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1296, 'User 1296', 'LGI6922782', '1970-06-29', '3898588337', 'user1296@example.com'),
(1297, 'User 1297', 'UVZ5478766', '1911-10-05', '9933086139', 'user1297@example.com'),
(1298, 'User 1298', 'CUM1082028', '1934-11-16', '0711815669', 'user1298@example.com'),
(1299, 'User 1299', 'TCE6147042', '1937-09-02', '0555532830', 'user1299@example.com'),
(1300, 'User 1300', 'TYR5808926', '1946-07-27', '6040254677', 'user1300@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1301, 'User 1301', 'PSX0697110', '1919-02-22', '5783379548', 'user1301@example.com'),
(1302, 'User 1302', 'MJJ4090942', '1967-03-10', '2201004349', 'user1302@example.com'),
(1303, 'User 1303', 'NKE1370594', '1940-09-29', '7605475460', 'user1303@example.com'),
(1304, 'User 1304', 'ECV4459146', '1975-08-08', '8848710981', 'user1304@example.com'),
(1305, 'User 1305', 'USQ2238571', '1977-07-23', '6080360906', 'user1305@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1306, 'User 1306', 'EKW7130336', '1966-01-11', '1622492816', 'user1306@example.com'),
(1307, 'User 1307', 'SRB2002416', '1940-03-16', '4788440500', 'user1307@example.com'),
(1308, 'User 1308', 'TEM9966197', '1924-02-28', '1568656266', 'user1308@example.com'),
(1309, 'User 1309', 'DAN1487620', '1949-09-13', '8973008879', 'user1309@example.com'),
(1310, 'User 1310', 'KAT1419938', '1915-07-16', '0307290687', 'user1310@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1311, 'User 1311', 'YDW9534723', '1929-03-11', '8929334540', 'user1311@example.com'),
(1312, 'User 1312', 'HUG3895342', '1980-07-15', '0362423781', 'user1312@example.com'),
(1313, 'User 1313', 'YTW1217402', '1960-05-10', '2315991071', 'user1313@example.com'),
(1314, 'User 1314', 'PPQ6678718', '1954-07-17', '4932341169', 'user1314@example.com'),
(1315, 'User 1315', 'WLO3092048', '1900-02-09', '5676341789', 'user1315@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1316, 'User 1316', 'NBX9574787', '1963-06-03', '3446630241', 'user1316@example.com'),
(1317, 'User 1317', 'WCG4261520', '1994-04-21', '0384353837', 'user1317@example.com'),
(1318, 'User 1318', 'WNE8700371', '1936-06-02', '2318312941', 'user1318@example.com'),
(1319, 'User 1319', 'JFO8990756', '1904-03-03', '5028275218', 'user1319@example.com'),
(1320, 'User 1320', 'AIK8933716', '1914-12-22', '0420648164', 'user1320@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1321, 'User 1321', 'YPY2229244', '1943-03-09', '1881900557', 'user1321@example.com'),
(1322, 'User 1322', 'GVV9740538', '1915-04-04', '5155269302', 'user1322@example.com'),
(1323, 'User 1323', 'WXL7530421', '1921-03-06', '9625765886', 'user1323@example.com'),
(1324, 'User 1324', 'OHC7794231', '1964-05-18', '2152383075', 'user1324@example.com'),
(1325, 'User 1325', 'NIE1544454', '1984-12-22', '4733038927', 'user1325@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1326, 'User 1326', 'TVZ9782930', '1933-01-05', '7568242020', 'user1326@example.com'),
(1327, 'User 1327', 'GUO0420628', '1952-06-16', '2756944216', 'user1327@example.com'),
(1328, 'User 1328', 'LZA5610386', '1918-04-07', '5353449150', 'user1328@example.com'),
(1329, 'User 1329', 'KEJ8876246', '1963-06-03', '6063485811', 'user1329@example.com'),
(1330, 'User 1330', 'AWM4890575', '1929-11-15', '1066620042', 'user1330@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1331, 'User 1331', 'YJU8400798', '2000-02-23', '1535611155', 'user1331@example.com'),
(1332, 'User 1332', 'LVX5593979', '1979-11-27', '9879724388', 'user1332@example.com'),
(1333, 'User 1333', 'EIG9482615', '1926-10-28', '2463329787', 'user1333@example.com'),
(1334, 'User 1334', 'PXE3452499', '1944-04-17', '1957017831', 'user1334@example.com'),
(1335, 'User 1335', 'NNK0467941', '1959-05-01', '5141505839', 'user1335@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1336, 'User 1336', 'QIY8644710', '1952-12-05', '2638358651', 'user1336@example.com'),
(1337, 'User 1337', 'DNT5082098', '2002-08-03', '7495656886', 'user1337@example.com'),
(1338, 'User 1338', 'HHH9368289', '2005-01-13', '7195939703', 'user1338@example.com'),
(1339, 'User 1339', 'IVF3381343', '1916-05-27', '1834880954', 'user1339@example.com'),
(1340, 'User 1340', 'FVI6593263', '1902-10-08', '2155960352', 'user1340@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1341, 'User 1341', 'LHJ1422022', '1900-06-21', '3043760220', 'user1341@example.com'),
(1342, 'User 1342', 'XMM3254588', '1942-11-02', '1599778881', 'user1342@example.com'),
(1343, 'User 1343', 'LWX8023837', '1922-06-22', '4651887774', 'user1343@example.com'),
(1344, 'User 1344', 'ELD4533900', '1902-08-21', '4859671968', 'user1344@example.com'),
(1345, 'User 1345', 'QRO1958153', '1949-10-26', '0354444396', 'user1345@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1346, 'User 1346', 'JVC7788962', '1959-01-12', '3410424230', 'user1346@example.com'),
(1347, 'User 1347', 'DJD3177296', '1985-04-05', '7751059864', 'user1347@example.com'),
(1348, 'User 1348', 'XVL0452395', '1980-09-18', '6874642024', 'user1348@example.com'),
(1349, 'User 1349', 'AIL3764698', '1900-02-25', '3745498126', 'user1349@example.com'),
(1350, 'User 1350', 'XWI4267413', '1907-05-30', '5856054871', 'user1350@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1351, 'User 1351', 'LUV0304994', '1965-04-07', '6977302303', 'user1351@example.com'),
(1352, 'User 1352', 'TPC4558433', '1983-02-14', '0104674839', 'user1352@example.com'),
(1353, 'User 1353', 'RUN1927507', '1928-02-21', '7648048507', 'user1353@example.com'),
(1354, 'User 1354', 'UPO6281680', '1906-11-19', '9560344133', 'user1354@example.com'),
(1355, 'User 1355', 'VAI1021950', '1919-03-12', '9426180572', 'user1355@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1356, 'User 1356', 'SMF8955938', '1911-09-23', '5252505534', 'user1356@example.com'),
(1357, 'User 1357', 'UWV0216696', '1982-08-19', '4412551466', 'user1357@example.com'),
(1358, 'User 1358', 'MIC8350011', '1932-09-27', '5669768395', 'user1358@example.com'),
(1359, 'User 1359', 'LXU8695062', '1953-12-02', '7313567365', 'user1359@example.com'),
(1360, 'User 1360', 'DYO5320537', '1927-03-13', '9240802590', 'user1360@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1361, 'User 1361', 'NIZ1961471', '1931-09-12', '4795696198', 'user1361@example.com'),
(1362, 'User 1362', 'KCW7080287', '1909-01-21', '6675218219', 'user1362@example.com'),
(1363, 'User 1363', 'DSF3674158', '1908-05-26', '0926390240', 'user1363@example.com'),
(1364, 'User 1364', 'VWF5129604', '1956-11-27', '2135783956', 'user1364@example.com'),
(1365, 'User 1365', 'GOZ0705016', '1900-06-29', '3929710136', 'user1365@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1366, 'User 1366', 'SMC5342380', '1935-05-09', '3877743336', 'user1366@example.com'),
(1367, 'User 1367', 'EZW1041764', '1947-11-24', '2638791219', 'user1367@example.com'),
(1368, 'User 1368', 'JRD0078992', '1994-08-25', '0018520688', 'user1368@example.com'),
(1369, 'User 1369', 'URC1411984', '1971-07-19', '2328250588', 'user1369@example.com'),
(1370, 'User 1370', 'ALB0433877', '1907-05-24', '0350994237', 'user1370@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1371, 'User 1371', 'HZC1297000', '1931-11-06', '5006101522', 'user1371@example.com'),
(1372, 'User 1372', 'RJT7291895', '1987-01-25', '0322895347', 'user1372@example.com'),
(1373, 'User 1373', 'KDG7321568', '1950-02-01', '8941636660', 'user1373@example.com'),
(1374, 'User 1374', 'DDW7753882', '1949-07-29', '9932507166', 'user1374@example.com'),
(1375, 'User 1375', 'SQC5779501', '1999-10-14', '1025326233', 'user1375@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1376, 'User 1376', 'GLL0435683', '1902-05-02', '5926440488', 'user1376@example.com'),
(1377, 'User 1377', 'BLL4774138', '1940-10-25', '4368918204', 'user1377@example.com'),
(1378, 'User 1378', 'SVF3215112', '1959-11-04', '6618490643', 'user1378@example.com'),
(1379, 'User 1379', 'VIV7759177', '1998-12-21', '6608024358', 'user1379@example.com'),
(1380, 'User 1380', 'QMS8235819', '1975-09-16', '1977484188', 'user1380@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1381, 'User 1381', 'GES1518779', '1924-09-23', '5591814307', 'user1381@example.com'),
(1382, 'User 1382', 'LJQ4232493', '1963-08-02', '4517754846', 'user1382@example.com'),
(1383, 'User 1383', 'UTZ5297743', '1986-10-16', '1660646244', 'user1383@example.com'),
(1384, 'User 1384', 'JRN1755218', '1940-06-07', '9736903847', 'user1384@example.com'),
(1385, 'User 1385', 'VKR8025473', '1940-07-02', '2267895374', 'user1385@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1386, 'User 1386', 'CRG8127976', '1939-04-22', '7166244489', 'user1386@example.com'),
(1387, 'User 1387', 'SMF5609670', '2002-01-25', '9655508835', 'user1387@example.com'),
(1388, 'User 1388', 'AVU3352198', '2001-05-21', '3824074348', 'user1388@example.com'),
(1389, 'User 1389', 'WAF4140367', '1917-07-23', '5458217658', 'user1389@example.com'),
(1390, 'User 1390', 'WLH7762038', '1945-09-10', '7112388802', 'user1390@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1391, 'User 1391', 'FPT4523322', '1944-05-19', '6463890321', 'user1391@example.com'),
(1392, 'User 1392', 'JGQ7350305', '1982-09-14', '1313355845', 'user1392@example.com'),
(1393, 'User 1393', 'YDO0846718', '1969-07-17', '6620154118', 'user1393@example.com'),
(1394, 'User 1394', 'JFF2884143', '1998-12-18', '4040285551', 'user1394@example.com'),
(1395, 'User 1395', 'TKY1560894', '1982-12-27', '7895090028', 'user1395@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1396, 'User 1396', 'HQL1230904', '1919-02-22', '0708919065', 'user1396@example.com'),
(1397, 'User 1397', 'ABF5326618', '1940-07-23', '9118714822', 'user1397@example.com'),
(1398, 'User 1398', 'LZT9663163', '1966-07-07', '5697846338', 'user1398@example.com'),
(1399, 'User 1399', 'ULR4821577', '1931-07-21', '0302326493', 'user1399@example.com'),
(1400, 'User 1400', 'IGF6573394', '1980-11-26', '3080068641', 'user1400@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1401, 'User 1401', 'DVG2687878', '1915-03-12', '5310774073', 'user1401@example.com'),
(1402, 'User 1402', 'OTL4676915', '1985-03-17', '0839637079', 'user1402@example.com'),
(1403, 'User 1403', 'UFC8809109', '1961-12-15', '8045537155', 'user1403@example.com'),
(1404, 'User 1404', 'WEF7011704', '1932-10-20', '7005011649', 'user1404@example.com'),
(1405, 'User 1405', 'EFQ7121836', '1956-06-06', '3573067318', 'user1405@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1406, 'User 1406', 'GJA3318073', '1987-03-18', '8780483602', 'user1406@example.com'),
(1407, 'User 1407', 'TRL5087652', '1924-08-22', '8094305150', 'user1407@example.com'),
(1408, 'User 1408', 'UOE3342632', '1945-05-21', '1169081784', 'user1408@example.com'),
(1409, 'User 1409', 'VBM2174046', '1964-11-24', '5944119924', 'user1409@example.com'),
(1410, 'User 1410', 'MID5209872', '1976-05-08', '1460488341', 'user1410@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1411, 'User 1411', 'KNL4431261', '1928-01-29', '3440972160', 'user1411@example.com'),
(1412, 'User 1412', 'SJB9730615', '1906-12-10', '4630234996', 'user1412@example.com'),
(1413, 'User 1413', 'VQR5024555', '1906-07-12', '9984899587', 'user1413@example.com'),
(1414, 'User 1414', 'WID0419654', '1927-10-01', '8458403747', 'user1414@example.com'),
(1415, 'User 1415', 'KHS4764957', '1985-01-22', '8243046104', 'user1415@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1416, 'User 1416', 'ODH2452098', '1915-06-24', '6487086542', 'user1416@example.com'),
(1417, 'User 1417', 'DZH3299378', '1905-04-29', '3435154289', 'user1417@example.com'),
(1418, 'User 1418', 'SMB4729703', '2004-02-01', '7736434630', 'user1418@example.com'),
(1419, 'User 1419', 'URW1604791', '1985-08-09', '4357919151', 'user1419@example.com'),
(1420, 'User 1420', 'KYG5993572', '1920-05-25', '1516239467', 'user1420@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1421, 'User 1421', 'XNY8052165', '1936-02-25', '5801833273', 'user1421@example.com'),
(1422, 'User 1422', 'DDU5733317', '2003-02-07', '0662088628', 'user1422@example.com'),
(1423, 'User 1423', 'OGM9308400', '1987-02-04', '9422709126', 'user1423@example.com'),
(1424, 'User 1424', 'DXL4304048', '1945-08-15', '1081814732', 'user1424@example.com'),
(1425, 'User 1425', 'BOL1317485', '1961-10-30', '7095657225', 'user1425@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1426, 'User 1426', 'FWY0794068', '1930-04-12', '0916058838', 'user1426@example.com'),
(1427, 'User 1427', 'MOI5856835', '1973-10-06', '9702573651', 'user1427@example.com'),
(1428, 'User 1428', 'WTD8916966', '1964-08-01', '9151671713', 'user1428@example.com'),
(1429, 'User 1429', 'ZAH3653749', '1997-02-03', '2154398727', 'user1429@example.com'),
(1430, 'User 1430', 'RZY3190826', '1934-05-06', '3424827452', 'user1430@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1431, 'User 1431', 'TQQ5580267', '1992-04-28', '7530527374', 'user1431@example.com'),
(1432, 'User 1432', 'YHE6676672', '1924-02-05', '5699492345', 'user1432@example.com'),
(1433, 'User 1433', 'ZHP2911954', '1929-09-07', '1660622484', 'user1433@example.com'),
(1434, 'User 1434', 'BYP6396900', '1985-11-19', '6562187098', 'user1434@example.com'),
(1435, 'User 1435', 'AWE8902111', '1947-01-10', '5569383848', 'user1435@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1436, 'User 1436', 'FIM8534496', '1979-09-03', '2716457829', 'user1436@example.com'),
(1437, 'User 1437', 'OCN6294007', '1924-10-03', '7839914386', 'user1437@example.com'),
(1438, 'User 1438', 'KDC2089684', '1900-06-23', '6514549359', 'user1438@example.com'),
(1439, 'User 1439', 'QZP6688831', '1998-05-03', '9357183374', 'user1439@example.com'),
(1440, 'User 1440', 'XAE8937126', '1941-12-09', '1164158970', 'user1440@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1441, 'User 1441', 'DVS9204383', '1951-08-12', '5442608395', 'user1441@example.com'),
(1442, 'User 1442', 'VCB1189086', '1989-12-05', '2635539624', 'user1442@example.com'),
(1443, 'User 1443', 'VIT1893201', '1917-02-23', '6059501865', 'user1443@example.com'),
(1444, 'User 1444', 'EEF0147000', '1939-02-11', '9131704400', 'user1444@example.com'),
(1445, 'User 1445', 'VYP3941535', '1978-11-24', '3975636762', 'user1445@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1446, 'User 1446', 'LHU8065626', '1943-05-02', '0184517548', 'user1446@example.com'),
(1447, 'User 1447', 'ZJE4186676', '1931-02-25', '3609049639', 'user1447@example.com'),
(1448, 'User 1448', 'LLZ1200966', '1924-03-29', '7455208320', 'user1448@example.com'),
(1449, 'User 1449', 'IFQ0867825', '1990-01-10', '6934779708', 'user1449@example.com'),
(1450, 'User 1450', 'EEE9199954', '1955-02-01', '7329685643', 'user1450@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1451, 'User 1451', 'UXK9604414', '1949-04-30', '9454404680', 'user1451@example.com'),
(1452, 'User 1452', 'HBM9270424', '1936-05-15', '7578469405', 'user1452@example.com'),
(1453, 'User 1453', 'URI3243196', '1905-07-01', '9253397005', 'user1453@example.com'),
(1454, 'User 1454', 'EVS7410299', '1944-06-21', '2165947634', 'user1454@example.com'),
(1455, 'User 1455', 'GZI8213324', '1968-03-27', '5526964989', 'user1455@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1456, 'User 1456', 'UWO3998098', '1903-11-20', '8443967491', 'user1456@example.com'),
(1457, 'User 1457', 'TVN1341256', '1968-05-12', '0211748930', 'user1457@example.com'),
(1458, 'User 1458', 'KOS2864601', '1957-04-14', '7960489438', 'user1458@example.com'),
(1459, 'User 1459', 'NFM6625503', '1909-12-02', '7085275741', 'user1459@example.com'),
(1460, 'User 1460', 'FGJ0751376', '1970-04-27', '0002846906', 'user1460@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1461, 'User 1461', 'DJO1160928', '1983-02-27', '1550505139', 'user1461@example.com'),
(1462, 'User 1462', 'JWE0152229', '1943-07-02', '8151880757', 'user1462@example.com'),
(1463, 'User 1463', 'PYI5800352', '1965-04-07', '4150583865', 'user1463@example.com'),
(1464, 'User 1464', 'PDU3551753', '1941-03-03', '6223405076', 'user1464@example.com'),
(1465, 'User 1465', 'ASR5215503', '1906-09-21', '5574731425', 'user1465@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1466, 'User 1466', 'SYU2667590', '1923-11-20', '1918461143', 'user1466@example.com'),
(1467, 'User 1467', 'USF3995918', '1909-01-26', '0883953506', 'user1467@example.com'),
(1468, 'User 1468', 'SSB5406550', '1962-03-28', '5757263449', 'user1468@example.com'),
(1469, 'User 1469', 'WKA1565964', '1978-02-07', '4487296519', 'user1469@example.com'),
(1470, 'User 1470', 'CBY0856048', '1975-08-19', '8819196643', 'user1470@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1471, 'User 1471', 'OJS1010132', '1972-07-28', '6037983724', 'user1471@example.com'),
(1472, 'User 1472', 'MBH9061631', '2003-05-07', '3344790644', 'user1472@example.com'),
(1473, 'User 1473', 'VWU9344119', '1929-05-25', '8920104687', 'user1473@example.com'),
(1474, 'User 1474', 'WWF3414623', '1952-09-13', '6151769929', 'user1474@example.com'),
(1475, 'User 1475', 'WDU9302375', '1939-01-28', '3420557782', 'user1475@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1476, 'User 1476', 'JWU9781855', '1901-08-10', '2815777837', 'user1476@example.com'),
(1477, 'User 1477', 'FNH0213560', '2001-05-22', '9014573681', 'user1477@example.com'),
(1478, 'User 1478', 'HOW4506591', '2000-11-19', '0139497779', 'user1478@example.com'),
(1479, 'User 1479', 'RYH0904350', '1978-07-30', '2726221397', 'user1479@example.com'),
(1480, 'User 1480', 'YCS6970823', '1927-12-13', '3098013310', 'user1480@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1481, 'User 1481', 'OGH8723825', '1965-02-05', '6374889153', 'user1481@example.com'),
(1482, 'User 1482', 'PHN7578072', '1925-04-02', '5273963299', 'user1482@example.com'),
(1483, 'User 1483', 'LSZ9869505', '1977-04-12', '5117091364', 'user1483@example.com'),
(1484, 'User 1484', 'ZHF1885264', '1934-06-10', '8185987554', 'user1484@example.com'),
(1485, 'User 1485', 'QQF1165045', '1963-06-11', '5444766373', 'user1485@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1486, 'User 1486', 'APB3093300', '2001-06-08', '2696627812', 'user1486@example.com'),
(1487, 'User 1487', 'WNO3996378', '1957-09-26', '5138727727', 'user1487@example.com'),
(1488, 'User 1488', 'XDP6227582', '1921-02-06', '5725017533', 'user1488@example.com'),
(1489, 'User 1489', 'JWH5077251', '1983-10-20', '8232164442', 'user1489@example.com'),
(1490, 'User 1490', 'HYF0540530', '1956-12-12', '7426255115', 'user1490@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1491, 'User 1491', 'HQD0244519', '2000-04-24', '6592715712', 'user1491@example.com'),
(1492, 'User 1492', 'IFI8705431', '1947-01-22', '9588719792', 'user1492@example.com'),
(1493, 'User 1493', 'NEM2757302', '1945-08-28', '5511272811', 'user1493@example.com'),
(1494, 'User 1494', 'ZPX4000124', '1909-07-08', '4535707385', 'user1494@example.com'),
(1495, 'User 1495', 'SSK1955782', '1996-02-10', '1040917039', 'user1495@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1496, 'User 1496', 'HUA7436890', '1998-03-05', '8618647372', 'user1496@example.com'),
(1497, 'User 1497', 'ZUP9076682', '1937-10-25', '1973689212', 'user1497@example.com'),
(1498, 'User 1498', 'OZY3642535', '1977-04-21', '2857308646', 'user1498@example.com'),
(1499, 'User 1499', 'GWH4338178', '1978-09-26', '6682877995', 'user1499@example.com'),
(1500, 'User 1500', 'XNM4978717', '1977-10-11', '0103330543', 'user1500@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1501, 'User 1501', 'XEZ0642801', '1960-07-17', '4467252233', 'user1501@example.com'),
(1502, 'User 1502', 'KJK3285038', '1969-02-16', '5549248134', 'user1502@example.com'),
(1503, 'User 1503', 'CIU1024340', '1988-05-14', '9137663784', 'user1503@example.com'),
(1504, 'User 1504', 'SWZ9331563', '1989-07-13', '6868748662', 'user1504@example.com'),
(1505, 'User 1505', 'XGD5419246', '1976-11-21', '0989099210', 'user1505@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1506, 'User 1506', 'NWH8877641', '1954-11-11', '9112374123', 'user1506@example.com'),
(1507, 'User 1507', 'TTJ2982945', '1904-05-19', '9650126321', 'user1507@example.com'),
(1508, 'User 1508', 'OPB3659272', '1966-01-13', '1455354980', 'user1508@example.com'),
(1509, 'User 1509', 'OJT0103685', '1997-12-20', '2230517661', 'user1509@example.com'),
(1510, 'User 1510', 'HAR2558834', '1972-01-19', '4397895587', 'user1510@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1511, 'User 1511', 'HZM2898731', '1987-07-27', '9802306872', 'user1511@example.com'),
(1512, 'User 1512', 'UAH6674207', '2000-05-24', '1100722797', 'user1512@example.com'),
(1513, 'User 1513', 'CDY6823995', '1986-07-11', '9221788120', 'user1513@example.com'),
(1514, 'User 1514', 'NTC4523961', '1903-03-03', '6475581231', 'user1514@example.com'),
(1515, 'User 1515', 'AGG3876190', '2004-02-10', '8733778990', 'user1515@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1516, 'User 1516', 'FBZ1650120', '1947-12-15', '2941303102', 'user1516@example.com'),
(1517, 'User 1517', 'LIZ9055374', '1971-08-16', '3345122361', 'user1517@example.com'),
(1518, 'User 1518', 'WCC1600837', '1925-08-18', '0788463066', 'user1518@example.com'),
(1519, 'User 1519', 'CME7701046', '1908-10-06', '8426852371', 'user1519@example.com'),
(1520, 'User 1520', 'AVT4788321', '1954-11-28', '2259580022', 'user1520@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1521, 'User 1521', 'HAL3617496', '1946-11-09', '4775650388', 'user1521@example.com'),
(1522, 'User 1522', 'HKD5625805', '1942-03-26', '2794635099', 'user1522@example.com'),
(1523, 'User 1523', 'IDO9128936', '2003-11-24', '0646740184', 'user1523@example.com'),
(1524, 'User 1524', 'HFL8765541', '1976-03-22', '3577769870', 'user1524@example.com'),
(1525, 'User 1525', 'UQF9902819', '1913-07-12', '0981141352', 'user1525@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1526, 'User 1526', 'YWT3936280', '1914-02-19', '9465553666', 'user1526@example.com'),
(1527, 'User 1527', 'AQK4645384', '1983-10-10', '4866662572', 'user1527@example.com'),
(1528, 'User 1528', 'POP8348751', '1930-04-12', '5446590867', 'user1528@example.com'),
(1529, 'User 1529', 'GIQ0544762', '1948-11-10', '2774737846', 'user1529@example.com'),
(1530, 'User 1530', 'LUP7374126', '1970-11-30', '6522200824', 'user1530@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1531, 'User 1531', 'YAQ6224247', '1921-09-06', '1647584804', 'user1531@example.com'),
(1532, 'User 1532', 'VZG2497745', '1960-10-20', '0410721337', 'user1532@example.com'),
(1533, 'User 1533', 'ITD4607224', '1968-07-14', '9654734940', 'user1533@example.com'),
(1534, 'User 1534', 'JIG3288867', '1966-03-25', '6942811209', 'user1534@example.com'),
(1535, 'User 1535', 'JKM3430966', '1997-08-16', '7991336217', 'user1535@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1536, 'User 1536', 'MGL8021014', '1982-07-24', '1235975809', 'user1536@example.com'),
(1537, 'User 1537', 'LKK6115331', '1958-04-18', '3257147647', 'user1537@example.com'),
(1538, 'User 1538', 'EEN0718663', '1956-03-21', '7557685041', 'user1538@example.com'),
(1539, 'User 1539', 'KBL0716362', '1900-09-27', '6915406957', 'user1539@example.com'),
(1540, 'User 1540', 'CFR9834236', '1971-08-24', '0305726293', 'user1540@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1541, 'User 1541', 'CKW9369869', '1956-02-08', '6372786199', 'user1541@example.com'),
(1542, 'User 1542', 'EZT7765888', '1957-03-23', '3495686430', 'user1542@example.com'),
(1543, 'User 1543', 'XTG7388971', '1907-06-03', '9560033183', 'user1543@example.com'),
(1544, 'User 1544', 'TVL6873480', '1952-01-10', '5406854627', 'user1544@example.com'),
(1545, 'User 1545', 'GXD6517209', '1953-03-08', '2755396604', 'user1545@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1546, 'User 1546', 'LKP8888168', '1956-12-09', '3027716917', 'user1546@example.com'),
(1547, 'User 1547', 'JHW9007692', '1978-11-19', '5505306557', 'user1547@example.com'),
(1548, 'User 1548', 'KKY6589450', '1915-08-07', '1168141434', 'user1548@example.com'),
(1549, 'User 1549', 'ICS4588466', '1955-01-12', '7076653395', 'user1549@example.com'),
(1550, 'User 1550', 'APR4725950', '1955-02-11', '9356073251', 'user1550@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1551, 'User 1551', 'HCI2659751', '1925-04-29', '9461249889', 'user1551@example.com'),
(1552, 'User 1552', 'FBB6183641', '1920-09-12', '4588856625', 'user1552@example.com'),
(1553, 'User 1553', 'OIU0626504', '1977-11-29', '9634249964', 'user1553@example.com'),
(1554, 'User 1554', 'QJK8563418', '1976-12-17', '7493163934', 'user1554@example.com'),
(1555, 'User 1555', 'QJS8732175', '1901-04-09', '2102294007', 'user1555@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1556, 'User 1556', 'PSU4336954', '1936-03-18', '7344059436', 'user1556@example.com'),
(1557, 'User 1557', 'UQX2070454', '1965-12-10', '9316480575', 'user1557@example.com'),
(1558, 'User 1558', 'LYU7746909', '1938-07-26', '6489409213', 'user1558@example.com'),
(1559, 'User 1559', 'EPC1530075', '1992-07-10', '6499765560', 'user1559@example.com'),
(1560, 'User 1560', 'FCW6293623', '1952-08-08', '1149292835', 'user1560@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1561, 'User 1561', 'EPV1710392', '1956-04-09', '5001234723', 'user1561@example.com'),
(1562, 'User 1562', 'TSM0152886', '1964-03-02', '9484410822', 'user1562@example.com'),
(1563, 'User 1563', 'XSJ4154380', '1987-04-27', '5234975552', 'user1563@example.com'),
(1564, 'User 1564', 'HCH7431642', '1939-11-26', '7796845632', 'user1564@example.com'),
(1565, 'User 1565', 'HIB6008064', '1965-05-28', '4452595860', 'user1565@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1566, 'User 1566', 'QBJ3967004', '1900-05-20', '0438274025', 'user1566@example.com'),
(1567, 'User 1567', 'XAS8887539', '1965-01-11', '5371873305', 'user1567@example.com'),
(1568, 'User 1568', 'UND2121585', '1971-01-16', '9017882492', 'user1568@example.com'),
(1569, 'User 1569', 'YXA1906094', '1995-03-23', '3140277878', 'user1569@example.com'),
(1570, 'User 1570', 'JGD1402477', '1912-05-06', '5570688949', 'user1570@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1571, 'User 1571', 'BHK5023482', '1988-02-12', '6390305595', 'user1571@example.com'),
(1572, 'User 1572', 'WDJ5774377', '1917-09-19', '3625171326', 'user1572@example.com'),
(1573, 'User 1573', 'NYZ1413787', '1993-04-16', '6770566917', 'user1573@example.com'),
(1574, 'User 1574', 'KXU2874801', '1938-12-18', '4915748483', 'user1574@example.com'),
(1575, 'User 1575', 'FBO7452334', '1907-01-23', '0043014668', 'user1575@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1576, 'User 1576', 'QZI4464771', '1941-05-18', '3653482830', 'user1576@example.com'),
(1577, 'User 1577', 'JDT7716621', '1989-07-16', '1707951918', 'user1577@example.com'),
(1578, 'User 1578', 'CWK7490077', '1935-11-10', '3573392282', 'user1578@example.com'),
(1579, 'User 1579', 'FZM9760313', '1995-11-04', '4246216723', 'user1579@example.com'),
(1580, 'User 1580', 'WST5682511', '2002-06-12', '0727919328', 'user1580@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1581, 'User 1581', 'NMC8407341', '1963-01-07', '9933309108', 'user1581@example.com'),
(1582, 'User 1582', 'DIQ8215360', '1940-12-17', '8382620960', 'user1582@example.com'),
(1583, 'User 1583', 'QDH4432792', '1980-06-01', '9169428604', 'user1583@example.com'),
(1584, 'User 1584', 'YPN7071458', '1970-11-01', '3316496386', 'user1584@example.com'),
(1585, 'User 1585', 'XGS8519926', '1907-05-07', '5801463342', 'user1585@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1586, 'User 1586', 'WJD0873851', '1943-07-16', '5275792591', 'user1586@example.com'),
(1587, 'User 1587', 'YGX8935065', '1930-07-03', '1804221930', 'user1587@example.com'),
(1588, 'User 1588', 'YOU0573945', '1983-03-30', '9548175010', 'user1588@example.com'),
(1589, 'User 1589', 'HTY5039152', '1932-12-10', '1927963750', 'user1589@example.com'),
(1590, 'User 1590', 'NBS2796619', '1974-06-26', '4989273702', 'user1590@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1591, 'User 1591', 'LJM4926743', '1907-01-23', '6829467473', 'user1591@example.com'),
(1592, 'User 1592', 'CNN8845717', '1945-09-12', '2637290876', 'user1592@example.com'),
(1593, 'User 1593', 'QOD9513238', '1957-06-21', '6757518980', 'user1593@example.com'),
(1594, 'User 1594', 'PFD8158212', '1911-11-28', '4544918835', 'user1594@example.com'),
(1595, 'User 1595', 'PST5480850', '1939-02-14', '1269904383', 'user1595@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1596, 'User 1596', 'PAX6592479', '1918-06-30', '8166971956', 'user1596@example.com'),
(1597, 'User 1597', 'DUI1475431', '1994-06-12', '9854757498', 'user1597@example.com'),
(1598, 'User 1598', 'TWA2853004', '1985-04-26', '4268880524', 'user1598@example.com'),
(1599, 'User 1599', 'KHM6286751', '1923-02-20', '1919601189', 'user1599@example.com'),
(1600, 'User 1600', 'JEA3143179', '2002-05-16', '7428757119', 'user1600@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1601, 'User 1601', 'HBQ8977883', '1909-08-07', '8102731834', 'user1601@example.com'),
(1602, 'User 1602', 'FCT7936567', '2003-11-23', '2938705115', 'user1602@example.com'),
(1603, 'User 1603', 'HTV9978556', '1937-05-02', '0932138319', 'user1603@example.com'),
(1604, 'User 1604', 'QLA2537241', '1982-09-14', '4704423693', 'user1604@example.com'),
(1605, 'User 1605', 'UBL1013581', '1944-08-18', '3841767431', 'user1605@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1606, 'User 1606', 'HKM7871747', '1953-03-23', '6524552256', 'user1606@example.com'),
(1607, 'User 1607', 'TRG6944026', '1966-07-26', '9863666742', 'user1607@example.com'),
(1608, 'User 1608', 'EYS7413804', '1907-06-12', '8311020512', 'user1608@example.com'),
(1609, 'User 1609', 'RFX0476117', '1921-07-15', '9679858201', 'user1609@example.com'),
(1610, 'User 1610', 'GAR0118185', '1933-09-01', '3625751609', 'user1610@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1611, 'User 1611', 'UQX5104643', '1971-09-18', '9704191608', 'user1611@example.com'),
(1612, 'User 1612', 'FEO5728573', '1954-01-10', '6784613682', 'user1612@example.com'),
(1613, 'User 1613', 'EGQ9273114', '1952-12-11', '5855678483', 'user1613@example.com'),
(1614, 'User 1614', 'TSX2549676', '1992-02-24', '2047089954', 'user1614@example.com'),
(1615, 'User 1615', 'YAS8244323', '1967-12-07', '3369071415', 'user1615@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1616, 'User 1616', 'VLW7646010', '1969-05-29', '2238948222', 'user1616@example.com'),
(1617, 'User 1617', 'MBO8305532', '1900-04-03', '1004698524', 'user1617@example.com'),
(1618, 'User 1618', 'ZTU9996981', '1973-09-25', '4599180588', 'user1618@example.com'),
(1619, 'User 1619', 'GTF4623488', '1983-02-18', '7566209988', 'user1619@example.com'),
(1620, 'User 1620', 'XEP1052364', '2005-08-18', '4481192863', 'user1620@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1621, 'User 1621', 'ZFA3139155', '1962-05-01', '5984194637', 'user1621@example.com'),
(1622, 'User 1622', 'OXE5888066', '2000-11-13', '6719756288', 'user1622@example.com'),
(1623, 'User 1623', 'HWP4968264', '1925-06-02', '5965109050', 'user1623@example.com'),
(1624, 'User 1624', 'FDV5198502', '1969-10-06', '7617161922', 'user1624@example.com'),
(1625, 'User 1625', 'QOD8684565', '1930-12-29', '3283309675', 'user1625@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1626, 'User 1626', 'ZEH1532545', '1926-07-01', '6619799460', 'user1626@example.com'),
(1627, 'User 1627', 'FXF2865568', '1912-04-14', '2564155311', 'user1627@example.com'),
(1628, 'User 1628', 'FOC3633679', '1993-11-06', '8732608908', 'user1628@example.com'),
(1629, 'User 1629', 'JGT9977963', '1945-01-05', '5926680661', 'user1629@example.com'),
(1630, 'User 1630', 'KWV2257276', '1911-04-15', '9641595499', 'user1630@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1631, 'User 1631', 'LEE8334647', '1915-08-26', '6528268978', 'user1631@example.com'),
(1632, 'User 1632', 'KWF1133065', '1944-08-09', '3026415012', 'user1632@example.com'),
(1633, 'User 1633', 'VRR3843338', '1914-09-06', '9858901789', 'user1633@example.com'),
(1634, 'User 1634', 'ITO8381712', '1970-05-02', '3591964255', 'user1634@example.com'),
(1635, 'User 1635', 'SUD0054307', '1928-04-12', '1210287269', 'user1635@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1636, 'User 1636', 'JDV0021509', '1990-11-21', '4729286403', 'user1636@example.com'),
(1637, 'User 1637', 'IUN6755373', '1920-08-22', '0590125762', 'user1637@example.com'),
(1638, 'User 1638', 'AGI2190264', '1943-03-02', '0436774759', 'user1638@example.com'),
(1639, 'User 1639', 'NXE2886811', '1964-11-30', '6152321923', 'user1639@example.com'),
(1640, 'User 1640', 'QQB1913805', '1909-07-30', '6362212850', 'user1640@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1641, 'User 1641', 'JEE1053781', '1910-08-02', '8416284315', 'user1641@example.com'),
(1642, 'User 1642', 'OVH2165449', '1943-01-10', '1010719513', 'user1642@example.com'),
(1643, 'User 1643', 'LWI6533916', '1914-04-08', '9078204007', 'user1643@example.com'),
(1644, 'User 1644', 'BSV1821806', '1930-10-30', '8371931374', 'user1644@example.com'),
(1645, 'User 1645', 'FLN1106506', '1930-10-16', '5070525267', 'user1645@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1646, 'User 1646', 'RRA0478770', '1902-05-15', '3230987147', 'user1646@example.com'),
(1647, 'User 1647', 'COG6493737', '1993-04-20', '8090706435', 'user1647@example.com'),
(1648, 'User 1648', 'CJS1073991', '1997-05-02', '4282044086', 'user1648@example.com'),
(1649, 'User 1649', 'KYR1019845', '1925-05-10', '5943246531', 'user1649@example.com'),
(1650, 'User 1650', 'CWO0759971', '1948-02-26', '0344226382', 'user1650@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1651, 'User 1651', 'AKO6101889', '1958-02-20', '3966175595', 'user1651@example.com'),
(1652, 'User 1652', 'FCK4439650', '1966-05-11', '8696911077', 'user1652@example.com'),
(1653, 'User 1653', 'TVE9941463', '1999-06-30', '8445974511', 'user1653@example.com'),
(1654, 'User 1654', 'NTJ8892315', '1902-04-26', '9693676914', 'user1654@example.com'),
(1655, 'User 1655', 'SGD8877295', '1983-01-17', '5635249652', 'user1655@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1656, 'User 1656', 'IGD2093913', '1974-04-23', '5272079402', 'user1656@example.com'),
(1657, 'User 1657', 'DKL9112466', '1940-12-10', '6942941656', 'user1657@example.com'),
(1658, 'User 1658', 'TAD9194342', '1987-03-13', '8221701218', 'user1658@example.com'),
(1659, 'User 1659', 'WLA6156606', '1991-06-20', '8722388499', 'user1659@example.com'),
(1660, 'User 1660', 'SWB2417956', '1994-07-20', '2516564697', 'user1660@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1661, 'User 1661', 'SZD4015702', '2005-02-19', '2985643015', 'user1661@example.com'),
(1662, 'User 1662', 'HFE9236436', '2002-03-04', '9721701324', 'user1662@example.com'),
(1663, 'User 1663', 'ZMZ8979303', '1968-03-09', '5950845389', 'user1663@example.com'),
(1664, 'User 1664', 'PUZ1219272', '1914-12-20', '6597050997', 'user1664@example.com'),
(1665, 'User 1665', 'TZH3823971', '1928-06-13', '7204260434', 'user1665@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1666, 'User 1666', 'HQC5733196', '1961-06-22', '8416174760', 'user1666@example.com'),
(1667, 'User 1667', 'ZOG6183568', '1911-12-05', '5598604707', 'user1667@example.com'),
(1668, 'User 1668', 'MPB8691840', '2001-07-01', '1640076283', 'user1668@example.com'),
(1669, 'User 1669', 'RHU4791455', '1940-02-08', '9130933821', 'user1669@example.com'),
(1670, 'User 1670', 'EZP3802117', '2002-03-27', '8611318549', 'user1670@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1671, 'User 1671', 'FUI3964830', '1937-02-06', '2516336590', 'user1671@example.com'),
(1672, 'User 1672', 'ZUT7545041', '1925-06-05', '0731806324', 'user1672@example.com'),
(1673, 'User 1673', 'XDI9854497', '1911-07-06', '0753673813', 'user1673@example.com'),
(1674, 'User 1674', 'CGG7296311', '1915-06-20', '3439997645', 'user1674@example.com'),
(1675, 'User 1675', 'XYO8738614', '1981-06-29', '3260493522', 'user1675@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1676, 'User 1676', 'RFU6227728', '1935-01-18', '9720757641', 'user1676@example.com'),
(1677, 'User 1677', 'DSK8421890', '1924-11-01', '4578838275', 'user1677@example.com'),
(1678, 'User 1678', 'AKQ7961098', '1954-10-11', '5675521898', 'user1678@example.com'),
(1679, 'User 1679', 'KOO8397293', '1903-07-18', '7919162813', 'user1679@example.com'),
(1680, 'User 1680', 'FAQ5906807', '1951-08-21', '4865861322', 'user1680@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1681, 'User 1681', 'LPY6952667', '1997-12-28', '5730748451', 'user1681@example.com'),
(1682, 'User 1682', 'RDD4494573', '1979-02-16', '7384880452', 'user1682@example.com'),
(1683, 'User 1683', 'JFT0714567', '1904-10-11', '7448776488', 'user1683@example.com'),
(1684, 'User 1684', 'BNW8491984', '1990-08-27', '2051478748', 'user1684@example.com'),
(1685, 'User 1685', 'DQD1455510', '1959-12-18', '9422428434', 'user1685@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1686, 'User 1686', 'XYQ4386603', '1967-03-19', '3653726028', 'user1686@example.com'),
(1687, 'User 1687', 'LVD7725928', '2003-05-07', '7562437088', 'user1687@example.com'),
(1688, 'User 1688', 'FLC3256517', '1990-08-23', '2136661849', 'user1688@example.com'),
(1689, 'User 1689', 'HBC3028182', '1995-09-16', '3965581329', 'user1689@example.com'),
(1690, 'User 1690', 'VXJ5429316', '1965-10-21', '0372949374', 'user1690@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1691, 'User 1691', 'TXI6598257', '1907-10-02', '8263039142', 'user1691@example.com'),
(1692, 'User 1692', 'UZL9913602', '1987-11-18', '8557357578', 'user1692@example.com'),
(1693, 'User 1693', 'FYW7470568', '1919-11-10', '3149242601', 'user1693@example.com'),
(1694, 'User 1694', 'EVE1307273', '1936-04-23', '5534745688', 'user1694@example.com'),
(1695, 'User 1695', 'VAT7818029', '1991-09-09', '6689334488', 'user1695@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1696, 'User 1696', 'ANX8129761', '1972-09-11', '8955885303', 'user1696@example.com'),
(1697, 'User 1697', 'PYP5773031', '1922-11-30', '0911566411', 'user1697@example.com'),
(1698, 'User 1698', 'FHK0539637', '1992-04-08', '4127733561', 'user1698@example.com'),
(1699, 'User 1699', 'OOD8307629', '1920-12-14', '2416883530', 'user1699@example.com'),
(1700, 'User 1700', 'CCA8452734', '1976-04-10', '6379633855', 'user1700@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1701, 'User 1701', 'RGQ7880899', '1970-07-13', '8843392998', 'user1701@example.com'),
(1702, 'User 1702', 'CLY1768779', '1936-08-26', '8472315477', 'user1702@example.com'),
(1703, 'User 1703', 'XDI7366949', '1999-01-29', '3749448409', 'user1703@example.com'),
(1704, 'User 1704', 'KUK7695375', '1907-05-09', '7815104870', 'user1704@example.com'),
(1705, 'User 1705', 'KGR6636121', '1908-06-02', '3076424242', 'user1705@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1706, 'User 1706', 'KKF7490878', '1936-07-25', '5491810938', 'user1706@example.com'),
(1707, 'User 1707', 'IYF4845092', '1973-12-25', '0779768927', 'user1707@example.com'),
(1708, 'User 1708', 'YHW2244843', '1994-05-25', '9248219456', 'user1708@example.com'),
(1709, 'User 1709', 'LRX9626515', '1951-03-08', '9087257911', 'user1709@example.com'),
(1710, 'User 1710', 'LKP2532946', '1976-09-11', '3330765390', 'user1710@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1711, 'User 1711', 'MAR5575378', '1934-04-27', '1502474868', 'user1711@example.com'),
(1712, 'User 1712', 'SLC8242801', '1936-09-28', '1568252441', 'user1712@example.com'),
(1713, 'User 1713', 'SEZ1063050', '2003-09-07', '6967836111', 'user1713@example.com'),
(1714, 'User 1714', 'XXP8217510', '1903-10-21', '4684346829', 'user1714@example.com'),
(1715, 'User 1715', 'LTG0977642', '1910-03-23', '5822803420', 'user1715@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1716, 'User 1716', 'WZJ7868722', '1944-01-25', '5334217271', 'user1716@example.com'),
(1717, 'User 1717', 'TJQ6983235', '1912-01-25', '1903000518', 'user1717@example.com'),
(1718, 'User 1718', 'XNV1499320', '1937-10-27', '0434547073', 'user1718@example.com'),
(1719, 'User 1719', 'TZT2615518', '1944-04-07', '1412115542', 'user1719@example.com'),
(1720, 'User 1720', 'OXP3798218', '2005-07-14', '8786714988', 'user1720@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1721, 'User 1721', 'TTT3887690', '1904-03-05', '6350047404', 'user1721@example.com'),
(1722, 'User 1722', 'HCL6764699', '1991-04-12', '8390445083', 'user1722@example.com'),
(1723, 'User 1723', 'QYA8877769', '1984-08-20', '1260605574', 'user1723@example.com'),
(1724, 'User 1724', 'QYE8531650', '2001-02-21', '0509096665', 'user1724@example.com'),
(1725, 'User 1725', 'ZHA5712863', '1900-03-18', '4189861485', 'user1725@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1726, 'User 1726', 'XXE8539392', '1935-08-19', '1756300517', 'user1726@example.com'),
(1727, 'User 1727', 'DAD1413773', '1973-11-02', '7017080926', 'user1727@example.com'),
(1728, 'User 1728', 'YBL3870508', '1949-11-08', '8766271588', 'user1728@example.com'),
(1729, 'User 1729', 'TOD5172132', '1978-12-06', '7666836976', 'user1729@example.com'),
(1730, 'User 1730', 'AAS5739930', '1986-06-04', '2468472467', 'user1730@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1731, 'User 1731', 'YMG1776817', '1963-07-27', '6131665352', 'user1731@example.com'),
(1732, 'User 1732', 'IDR3187966', '1991-11-15', '2346238184', 'user1732@example.com'),
(1733, 'User 1733', 'KUH2381676', '1902-08-26', '5313150693', 'user1733@example.com'),
(1734, 'User 1734', 'HEN3777339', '1983-07-27', '4509824601', 'user1734@example.com'),
(1735, 'User 1735', 'XTL3250860', '1995-03-22', '9251776486', 'user1735@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1736, 'User 1736', 'XZW2267911', '1917-12-30', '5837010387', 'user1736@example.com'),
(1737, 'User 1737', 'KAR7118507', '1912-06-11', '2946002260', 'user1737@example.com'),
(1738, 'User 1738', 'JVY5539364', '1969-05-16', '8480258345', 'user1738@example.com'),
(1739, 'User 1739', 'UDU8531708', '1973-06-14', '9481384693', 'user1739@example.com'),
(1740, 'User 1740', 'HBH9203773', '1966-08-15', '9596018985', 'user1740@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1741, 'User 1741', 'QMU4842663', '1907-02-04', '8824363769', 'user1741@example.com'),
(1742, 'User 1742', 'XZH4364076', '1974-03-21', '4983155968', 'user1742@example.com'),
(1743, 'User 1743', 'WTN3174973', '1982-05-27', '8856879752', 'user1743@example.com'),
(1744, 'User 1744', 'VXE0963844', '1982-03-29', '7801505621', 'user1744@example.com'),
(1745, 'User 1745', 'WFU3199145', '1916-09-20', '8600736648', 'user1745@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1746, 'User 1746', 'QUV0435281', '1953-07-11', '3362358631', 'user1746@example.com'),
(1747, 'User 1747', 'OWM4744463', '1994-08-27', '4147067261', 'user1747@example.com'),
(1748, 'User 1748', 'QED9040763', '1949-05-17', '7054885449', 'user1748@example.com'),
(1749, 'User 1749', 'XOI6569740', '1936-09-15', '6631798217', 'user1749@example.com'),
(1750, 'User 1750', 'IBA3833845', '1933-08-11', '8934456628', 'user1750@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1751, 'User 1751', 'CXB6522345', '1961-03-23', '8849186778', 'user1751@example.com'),
(1752, 'User 1752', 'PKT9136551', '1954-09-04', '6933732093', 'user1752@example.com'),
(1753, 'User 1753', 'HKM7900686', '1980-07-24', '4884700583', 'user1753@example.com'),
(1754, 'User 1754', 'ZEI9685036', '1977-04-09', '1901430579', 'user1754@example.com'),
(1755, 'User 1755', 'GNY2930579', '2005-03-29', '6463698029', 'user1755@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1756, 'User 1756', 'EWD5096396', '1911-06-09', '7379839678', 'user1756@example.com'),
(1757, 'User 1757', 'GCP3892419', '2001-07-11', '1465670919', 'user1757@example.com'),
(1758, 'User 1758', 'CJG8653318', '1902-12-01', '4891640534', 'user1758@example.com'),
(1759, 'User 1759', 'BMF4387881', '1954-02-26', '1562357531', 'user1759@example.com'),
(1760, 'User 1760', 'UCJ1009340', '1995-11-12', '6776125172', 'user1760@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1761, 'User 1761', 'IZZ3370445', '1991-02-26', '0223778647', 'user1761@example.com'),
(1762, 'User 1762', 'SPQ2614634', '1981-04-15', '7837229701', 'user1762@example.com'),
(1763, 'User 1763', 'YJL5499206', '1926-04-02', '9690202759', 'user1763@example.com'),
(1764, 'User 1764', 'KYW6322243', '1944-08-21', '6282339714', 'user1764@example.com'),
(1765, 'User 1765', 'WPI6587483', '1922-02-17', '2082287627', 'user1765@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1766, 'User 1766', 'EZI8207364', '1962-08-15', '2978735983', 'user1766@example.com'),
(1767, 'User 1767', 'WCP8890496', '1957-03-01', '1058607358', 'user1767@example.com'),
(1768, 'User 1768', 'DVZ4970425', '1901-02-16', '3031916422', 'user1768@example.com'),
(1769, 'User 1769', 'MBL3270480', '1986-09-22', '2120421333', 'user1769@example.com'),
(1770, 'User 1770', 'HRX8744370', '1977-10-12', '1845935262', 'user1770@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1771, 'User 1771', 'AXE2743812', '1977-12-24', '0791040642', 'user1771@example.com'),
(1772, 'User 1772', 'WAK8803520', '1943-01-14', '7644713102', 'user1772@example.com'),
(1773, 'User 1773', 'EJI4067870', '1970-02-24', '1059371812', 'user1773@example.com'),
(1774, 'User 1774', 'CEN0894232', '2004-05-28', '5891246568', 'user1774@example.com'),
(1775, 'User 1775', 'DEQ3297847', '1987-09-18', '8569802895', 'user1775@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1776, 'User 1776', 'MXL3526641', '1930-04-05', '0304857060', 'user1776@example.com'),
(1777, 'User 1777', 'GYE1490320', '1947-06-05', '5123597541', 'user1777@example.com'),
(1778, 'User 1778', 'CUE5238115', '1982-12-12', '9453231484', 'user1778@example.com'),
(1779, 'User 1779', 'JGZ5556734', '1934-08-27', '5316656170', 'user1779@example.com'),
(1780, 'User 1780', 'SVP9781366', '1933-07-20', '5374055862', 'user1780@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1781, 'User 1781', 'VOX8168216', '1918-03-16', '5104671238', 'user1781@example.com'),
(1782, 'User 1782', 'HBH5689529', '1927-08-09', '4199908497', 'user1782@example.com'),
(1783, 'User 1783', 'NFS2316810', '1929-11-20', '6479124302', 'user1783@example.com'),
(1784, 'User 1784', 'PBY1235137', '1964-06-29', '8378739515', 'user1784@example.com'),
(1785, 'User 1785', 'OWC7193926', '1977-06-25', '2230965609', 'user1785@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1786, 'User 1786', 'YQT2459642', '1961-10-25', '5939084775', 'user1786@example.com'),
(1787, 'User 1787', 'NCS7552610', '1916-02-11', '8611630213', 'user1787@example.com'),
(1788, 'User 1788', 'IJS6898166', '1910-10-29', '4854705249', 'user1788@example.com'),
(1789, 'User 1789', 'TKR9774035', '1987-05-19', '0483199170', 'user1789@example.com'),
(1790, 'User 1790', 'ZFU9893766', '2001-07-22', '4029808630', 'user1790@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1791, 'User 1791', 'GWJ8406501', '1981-05-04', '0556493193', 'user1791@example.com'),
(1792, 'User 1792', 'DAC4903622', '1944-01-22', '1412203863', 'user1792@example.com'),
(1793, 'User 1793', 'ORS2964373', '1961-05-05', '1652213893', 'user1793@example.com'),
(1794, 'User 1794', 'LGC1116551', '1910-01-17', '2782516622', 'user1794@example.com'),
(1795, 'User 1795', 'UGV5668208', '1974-12-14', '9394971238', 'user1795@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1796, 'User 1796', 'MNT8610960', '1963-01-06', '6912729780', 'user1796@example.com'),
(1797, 'User 1797', 'EJY8019385', '2000-09-30', '7848162472', 'user1797@example.com'),
(1798, 'User 1798', 'XQL5078939', '1975-05-01', '7070835067', 'user1798@example.com'),
(1799, 'User 1799', 'IQB9749885', '1973-12-13', '1349220127', 'user1799@example.com'),
(1800, 'User 1800', 'ZCU6241532', '1907-11-24', '8397781687', 'user1800@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1801, 'User 1801', 'DWF6449982', '1981-06-14', '7846038996', 'user1801@example.com'),
(1802, 'User 1802', 'NIS0857010', '1978-01-07', '2401138080', 'user1802@example.com'),
(1803, 'User 1803', 'KGN6952916', '1922-05-24', '2218608872', 'user1803@example.com'),
(1804, 'User 1804', 'PWT8789583', '1958-06-09', '4268897093', 'user1804@example.com'),
(1805, 'User 1805', 'IWJ4477920', '1938-04-28', '1945759611', 'user1805@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1806, 'User 1806', 'IAX5033471', '1982-06-08', '1708322668', 'user1806@example.com'),
(1807, 'User 1807', 'XMU2752506', '1920-01-27', '8953256347', 'user1807@example.com'),
(1808, 'User 1808', 'JQC3286624', '1990-08-07', '2753541390', 'user1808@example.com'),
(1809, 'User 1809', 'IDN1249001', '1943-05-11', '2422903070', 'user1809@example.com'),
(1810, 'User 1810', 'IRP9149742', '1904-07-18', '8942471141', 'user1810@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1811, 'User 1811', 'IQW8984109', '1940-02-07', '3965795658', 'user1811@example.com'),
(1812, 'User 1812', 'HEM2181576', '1966-05-26', '8933810177', 'user1812@example.com'),
(1813, 'User 1813', 'YIV5019042', '1913-09-28', '9628783059', 'user1813@example.com'),
(1814, 'User 1814', 'ERS8902104', '1924-05-12', '8365821066', 'user1814@example.com'),
(1815, 'User 1815', 'UJI4956692', '1957-11-18', '4090335677', 'user1815@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1816, 'User 1816', 'PYJ7509986', '1987-05-19', '0432686774', 'user1816@example.com'),
(1817, 'User 1817', 'WQT6383781', '1903-06-10', '0187620255', 'user1817@example.com'),
(1818, 'User 1818', 'BEX1331190', '1972-05-08', '1758184689', 'user1818@example.com'),
(1819, 'User 1819', 'UWW1110806', '1911-01-17', '7583304429', 'user1819@example.com'),
(1820, 'User 1820', 'KNA8277994', '1912-01-06', '6454460950', 'user1820@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1821, 'User 1821', 'JDE8816567', '1919-08-24', '7088847262', 'user1821@example.com'),
(1822, 'User 1822', 'XGW2898183', '1922-06-22', '2229357436', 'user1822@example.com'),
(1823, 'User 1823', 'LER7441589', '1986-01-24', '4091307251', 'user1823@example.com'),
(1824, 'User 1824', 'PZU6715233', '1937-08-12', '1715604918', 'user1824@example.com'),
(1825, 'User 1825', 'QXW1828252', '1955-11-23', '4588904627', 'user1825@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1826, 'User 1826', 'WYH1441564', '1960-06-18', '8149892346', 'user1826@example.com'),
(1827, 'User 1827', 'ZDC6218733', '1917-09-30', '5944502258', 'user1827@example.com'),
(1828, 'User 1828', 'QVZ9869257', '1977-01-16', '6379142625', 'user1828@example.com'),
(1829, 'User 1829', 'TVF9836899', '1989-06-13', '9618400402', 'user1829@example.com'),
(1830, 'User 1830', 'JLQ7393523', '1946-08-13', '5805230825', 'user1830@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1831, 'User 1831', 'ZEW2390287', '1932-02-17', '0747248112', 'user1831@example.com'),
(1832, 'User 1832', 'RUG6474012', '2004-01-28', '4835517350', 'user1832@example.com'),
(1833, 'User 1833', 'BJT5269521', '1936-03-11', '5728005340', 'user1833@example.com'),
(1834, 'User 1834', 'MBW3046162', '1913-05-10', '2189546197', 'user1834@example.com'),
(1835, 'User 1835', 'OUG0471996', '1910-09-05', '3250394595', 'user1835@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1836, 'User 1836', 'BGL9335640', '1963-01-01', '2744810996', 'user1836@example.com'),
(1837, 'User 1837', 'ARP0871955', '1997-01-02', '2523499136', 'user1837@example.com'),
(1838, 'User 1838', 'QOT6905503', '1986-03-29', '7830545116', 'user1838@example.com'),
(1839, 'User 1839', 'IUF6342230', '1930-09-25', '4248992366', 'user1839@example.com'),
(1840, 'User 1840', 'GYZ0674289', '1915-06-21', '4428962089', 'user1840@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1841, 'User 1841', 'YSN3616972', '1939-07-01', '0819193059', 'user1841@example.com'),
(1842, 'User 1842', 'VTW2563345', '1995-06-15', '5462513263', 'user1842@example.com'),
(1843, 'User 1843', 'IBJ2232454', '1961-01-18', '7818303709', 'user1843@example.com'),
(1844, 'User 1844', 'BLG4365805', '1925-09-04', '0970210953', 'user1844@example.com'),
(1845, 'User 1845', 'YTJ4820150', '1977-08-01', '2256646917', 'user1845@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1846, 'User 1846', 'PQP0054528', '1992-11-13', '2912482888', 'user1846@example.com'),
(1847, 'User 1847', 'HNO3902676', '1961-06-24', '5946458549', 'user1847@example.com'),
(1848, 'User 1848', 'XRL3970476', '1992-06-03', '7930421706', 'user1848@example.com'),
(1849, 'User 1849', 'DUC1862099', '1952-06-29', '4832490160', 'user1849@example.com'),
(1850, 'User 1850', 'IQO5944439', '1982-04-23', '3829377971', 'user1850@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1851, 'User 1851', 'PMO3480144', '1919-10-01', '4161157647', 'user1851@example.com'),
(1852, 'User 1852', 'UWA7076403', '1932-03-17', '3045251002', 'user1852@example.com'),
(1853, 'User 1853', 'HRN8372098', '1921-03-11', '5460403929', 'user1853@example.com'),
(1854, 'User 1854', 'UFS9119623', '1936-03-05', '6782813027', 'user1854@example.com'),
(1855, 'User 1855', 'XPA2772565', '1979-02-12', '9457899341', 'user1855@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1856, 'User 1856', 'GCA7476626', '1999-11-20', '1246546865', 'user1856@example.com'),
(1857, 'User 1857', 'DUN9992463', '1911-05-02', '3080916896', 'user1857@example.com'),
(1858, 'User 1858', 'PIJ9779113', '2000-10-29', '4733728188', 'user1858@example.com'),
(1859, 'User 1859', 'EVQ0541973', '1984-06-30', '2058293747', 'user1859@example.com'),
(1860, 'User 1860', 'YBP5303875', '1944-02-16', '3676955141', 'user1860@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1861, 'User 1861', 'SLU6650021', '1939-11-29', '3515201290', 'user1861@example.com'),
(1862, 'User 1862', 'BWM6277110', '2001-04-28', '8528222754', 'user1862@example.com'),
(1863, 'User 1863', 'PEE5625157', '1948-03-13', '4580715498', 'user1863@example.com'),
(1864, 'User 1864', 'DQI5167675', '1911-10-25', '3259558622', 'user1864@example.com'),
(1865, 'User 1865', 'FYZ3464330', '1907-06-26', '5488618781', 'user1865@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1866, 'User 1866', 'KEA2480435', '1970-08-18', '8873670525', 'user1866@example.com'),
(1867, 'User 1867', 'LTS6297283', '1971-08-11', '8765496735', 'user1867@example.com'),
(1868, 'User 1868', 'YGD8699306', '1958-04-30', '3256061549', 'user1868@example.com'),
(1869, 'User 1869', 'ZWE4744948', '1955-08-04', '2924009364', 'user1869@example.com'),
(1870, 'User 1870', 'YSN6363497', '1983-02-18', '8565370184', 'user1870@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1871, 'User 1871', 'ONG4082467', '1962-04-19', '4531885762', 'user1871@example.com'),
(1872, 'User 1872', 'LNJ3033891', '1999-10-07', '7924266669', 'user1872@example.com'),
(1873, 'User 1873', 'EYP6571237', '1964-09-23', '9940622987', 'user1873@example.com'),
(1874, 'User 1874', 'TOD5141252', '1922-04-07', '2611941715', 'user1874@example.com'),
(1875, 'User 1875', 'HTB8680070', '1919-01-19', '9017216125', 'user1875@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1876, 'User 1876', 'VSJ8978789', '1970-11-17', '2084577965', 'user1876@example.com'),
(1877, 'User 1877', 'UGP3046275', '1963-11-21', '0319430714', 'user1877@example.com'),
(1878, 'User 1878', 'CJU0467173', '1914-01-16', '2981963120', 'user1878@example.com'),
(1879, 'User 1879', 'PMU5412360', '1924-03-06', '8320321945', 'user1879@example.com'),
(1880, 'User 1880', 'XNY3527197', '1973-05-19', '0745236811', 'user1880@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1881, 'User 1881', 'ADI2110761', '1910-12-11', '8566727222', 'user1881@example.com'),
(1882, 'User 1882', 'EIS3828287', '1917-06-05', '0307876653', 'user1882@example.com'),
(1883, 'User 1883', 'QVV9955280', '1960-04-15', '7787586243', 'user1883@example.com'),
(1884, 'User 1884', 'SKX0990386', '1980-12-07', '2856614873', 'user1884@example.com'),
(1885, 'User 1885', 'ADB4531667', '1922-10-27', '0780887832', 'user1885@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1886, 'User 1886', 'SKA6456808', '1980-11-10', '8897937010', 'user1886@example.com'),
(1887, 'User 1887', 'UWT1753642', '1906-08-21', '2699153169', 'user1887@example.com'),
(1888, 'User 1888', 'QLD0521428', '1954-08-22', '8953179262', 'user1888@example.com'),
(1889, 'User 1889', 'ZIK9119657', '1922-06-20', '0721044360', 'user1889@example.com'),
(1890, 'User 1890', 'IZQ2504441', '1991-11-07', '2405303537', 'user1890@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1891, 'User 1891', 'VYN1815033', '1979-12-24', '8381791956', 'user1891@example.com'),
(1892, 'User 1892', 'IVM8926651', '1909-10-06', '3077555355', 'user1892@example.com'),
(1893, 'User 1893', 'HCC1511258', '1933-02-16', '4142901736', 'user1893@example.com'),
(1894, 'User 1894', 'PGQ9654609', '1934-12-02', '5537535589', 'user1894@example.com'),
(1895, 'User 1895', 'MLJ8059145', '1928-05-07', '8699670030', 'user1895@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1896, 'User 1896', 'MRA3563222', '1975-08-21', '5365173475', 'user1896@example.com'),
(1897, 'User 1897', 'RYJ7334506', '1997-01-23', '9113393272', 'user1897@example.com'),
(1898, 'User 1898', 'QWO2125923', '1966-05-30', '8768843026', 'user1898@example.com'),
(1899, 'User 1899', 'TVD3714555', '1932-01-09', '9640194818', 'user1899@example.com'),
(1900, 'User 1900', 'ETL1670867', '1994-01-21', '9473016367', 'user1900@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1901, 'User 1901', 'SSG5601220', '1938-09-11', '6194391049', 'user1901@example.com'),
(1902, 'User 1902', 'HVY0965419', '1991-01-01', '6535172685', 'user1902@example.com'),
(1903, 'User 1903', 'RWE4025680', '1903-11-15', '0996065530', 'user1903@example.com'),
(1904, 'User 1904', 'VLF5259871', '1936-02-20', '8095935003', 'user1904@example.com'),
(1905, 'User 1905', 'LBL2013220', '1935-02-21', '2752243725', 'user1905@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1906, 'User 1906', 'RAG3471232', '1935-11-04', '0724261820', 'user1906@example.com'),
(1907, 'User 1907', 'GXI8739766', '1990-06-13', '8309687667', 'user1907@example.com'),
(1908, 'User 1908', 'VGJ6369010', '1928-06-11', '8825576024', 'user1908@example.com'),
(1909, 'User 1909', 'SPC1087819', '1922-09-08', '9287520822', 'user1909@example.com'),
(1910, 'User 1910', 'TPT6911753', '1923-08-13', '1709682097', 'user1910@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1911, 'User 1911', 'EET6809682', '1974-12-22', '7813365748', 'user1911@example.com'),
(1912, 'User 1912', 'CGA4260083', '2004-04-29', '1858226883', 'user1912@example.com'),
(1913, 'User 1913', 'EVF3851130', '2001-11-06', '0936965519', 'user1913@example.com'),
(1914, 'User 1914', 'UQE5154492', '1931-08-21', '1866502694', 'user1914@example.com'),
(1915, 'User 1915', 'DNF2048819', '1983-05-16', '3359669334', 'user1915@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1916, 'User 1916', 'RGN1988035', '1911-06-08', '3917323247', 'user1916@example.com'),
(1917, 'User 1917', 'IJS4832536', '1923-06-27', '1090478949', 'user1917@example.com'),
(1918, 'User 1918', 'IHF6953413', '1968-01-18', '7793706486', 'user1918@example.com'),
(1919, 'User 1919', 'WHZ8753578', '1962-12-18', '0789089925', 'user1919@example.com'),
(1920, 'User 1920', 'XDX0003344', '1960-07-30', '3012934513', 'user1920@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1921, 'User 1921', 'LKX4411064', '1939-04-01', '3303734067', 'user1921@example.com'),
(1922, 'User 1922', 'TKB9964913', '1997-03-23', '1755863018', 'user1922@example.com'),
(1923, 'User 1923', 'EQA8725505', '1982-06-12', '1422676765', 'user1923@example.com'),
(1924, 'User 1924', 'NXP6116794', '1935-05-04', '9568066337', 'user1924@example.com'),
(1925, 'User 1925', 'BZN1111389', '1934-01-03', '0663071727', 'user1925@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1926, 'User 1926', 'QLN3819289', '1920-12-01', '4388634357', 'user1926@example.com'),
(1927, 'User 1927', 'MET2422609', '2005-10-11', '9042268937', 'user1927@example.com'),
(1928, 'User 1928', 'HYU6465370', '1975-02-14', '4929454641', 'user1928@example.com'),
(1929, 'User 1929', 'NZQ2271839', '1941-11-14', '5246316410', 'user1929@example.com'),
(1930, 'User 1930', 'IZD8209489', '1928-02-12', '8570744512', 'user1930@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1931, 'User 1931', 'UJC5630689', '1973-10-03', '2550443843', 'user1931@example.com'),
(1932, 'User 1932', 'QNN0573234', '1952-12-25', '2880613752', 'user1932@example.com'),
(1933, 'User 1933', 'MLT1953251', '1965-02-13', '4799504414', 'user1933@example.com'),
(1934, 'User 1934', 'PGF2177175', '1998-01-28', '8812968965', 'user1934@example.com'),
(1935, 'User 1935', 'FXY5392673', '1948-05-05', '5545283132', 'user1935@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1936, 'User 1936', 'JYY7279993', '1911-08-18', '2219860594', 'user1936@example.com'),
(1937, 'User 1937', 'GIZ0117600', '1938-03-20', '1705755661', 'user1937@example.com'),
(1938, 'User 1938', 'RJT9853107', '1932-05-29', '5441994346', 'user1938@example.com'),
(1939, 'User 1939', 'LPX6340818', '1990-05-13', '1329899791', 'user1939@example.com'),
(1940, 'User 1940', 'ZXV7559477', '1949-01-23', '5327335385', 'user1940@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1941, 'User 1941', 'POA5006455', '2003-05-23', '1074040208', 'user1941@example.com'),
(1942, 'User 1942', 'MJP1058430', '1929-06-15', '0848292004', 'user1942@example.com'),
(1943, 'User 1943', 'ZYT8808675', '1966-05-30', '0623882289', 'user1943@example.com'),
(1944, 'User 1944', 'MOS3061610', '1934-05-19', '8800044155', 'user1944@example.com'),
(1945, 'User 1945', 'GKU6041362', '1978-12-24', '5469762692', 'user1945@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1946, 'User 1946', 'WAK0801235', '1948-01-10', '2392939061', 'user1946@example.com'),
(1947, 'User 1947', 'HER0974608', '1963-10-21', '5639802781', 'user1947@example.com'),
(1948, 'User 1948', 'EJD1412557', '1905-03-23', '3317826274', 'user1948@example.com'),
(1949, 'User 1949', 'CQL0535401', '1958-05-20', '6119608896', 'user1949@example.com'),
(1950, 'User 1950', 'YSU4530068', '1919-12-19', '4602251959', 'user1950@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1951, 'User 1951', 'GDE3812571', '1909-03-09', '1594220393', 'user1951@example.com'),
(1952, 'User 1952', 'WVC4727470', '1975-11-29', '6876095592', 'user1952@example.com'),
(1953, 'User 1953', 'CCC5392244', '1919-06-08', '9608039590', 'user1953@example.com'),
(1954, 'User 1954', 'LMQ4474254', '1955-11-20', '5930661058', 'user1954@example.com'),
(1955, 'User 1955', 'VDP2481460', '1987-11-20', '9027620690', 'user1955@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1956, 'User 1956', 'OJJ3351741', '1916-03-17', '8914577970', 'user1956@example.com'),
(1957, 'User 1957', 'ZTC6417755', '1916-02-04', '6972388278', 'user1957@example.com'),
(1958, 'User 1958', 'FZX2205004', '1912-12-27', '1526795259', 'user1958@example.com'),
(1959, 'User 1959', 'KBG8823030', '1912-05-13', '6651078172', 'user1959@example.com'),
(1960, 'User 1960', 'TRN0557117', '1956-06-25', '2373174543', 'user1960@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1961, 'User 1961', 'MOJ2889332', '1988-11-29', '0400460069', 'user1961@example.com'),
(1962, 'User 1962', 'PSN9177568', '2004-04-06', '5181871941', 'user1962@example.com'),
(1963, 'User 1963', 'KCZ6123067', '1923-05-07', '0223692721', 'user1963@example.com'),
(1964, 'User 1964', 'ARZ6182846', '1914-08-29', '1705365373', 'user1964@example.com'),
(1965, 'User 1965', 'JMI3742465', '2004-01-28', '0777980224', 'user1965@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1966, 'User 1966', 'PZY9145571', '1997-01-23', '3001953974', 'user1966@example.com'),
(1967, 'User 1967', 'LVJ2260872', '1982-04-26', '5791140327', 'user1967@example.com'),
(1968, 'User 1968', 'LBS7315807', '1981-02-11', '3829946715', 'user1968@example.com'),
(1969, 'User 1969', 'ZWT1722112', '1986-01-15', '7692322966', 'user1969@example.com'),
(1970, 'User 1970', 'HNZ0026097', '1977-09-21', '8131362197', 'user1970@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1971, 'User 1971', 'ZSC4771627', '1959-04-17', '9783493866', 'user1971@example.com'),
(1972, 'User 1972', 'NNP1553920', '1959-04-13', '8449490649', 'user1972@example.com'),
(1973, 'User 1973', 'ANK9222660', '1914-08-19', '1738822443', 'user1973@example.com'),
(1974, 'User 1974', 'ZTJ5331298', '1904-09-09', '8607308209', 'user1974@example.com'),
(1975, 'User 1975', 'LNR2727580', '1954-10-03', '6748137532', 'user1975@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1976, 'User 1976', 'UHT4456709', '1938-03-08', '6631536191', 'user1976@example.com'),
(1977, 'User 1977', 'JYL9795110', '1989-03-14', '6912247909', 'user1977@example.com'),
(1978, 'User 1978', 'HDK8119559', '1990-11-15', '5084782316', 'user1978@example.com'),
(1979, 'User 1979', 'MIV1840671', '1947-05-27', '1666263499', 'user1979@example.com'),
(1980, 'User 1980', 'PCA4535542', '1960-12-23', '8327202741', 'user1980@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1981, 'User 1981', 'YXD2230970', '1918-05-23', '9747501088', 'user1981@example.com'),
(1982, 'User 1982', 'QFY9605237', '1976-04-25', '4602502003', 'user1982@example.com'),
(1983, 'User 1983', 'NSJ9952722', '1932-05-28', '5713694031', 'user1983@example.com'),
(1984, 'User 1984', 'YKQ8782796', '1931-03-27', '4712050259', 'user1984@example.com'),
(1985, 'User 1985', 'RMB5650918', '1973-02-14', '9329556021', 'user1985@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1986, 'User 1986', 'NFK8773440', '1968-04-21', '1595405259', 'user1986@example.com'),
(1987, 'User 1987', 'HFG2821739', '1914-01-06', '2536126317', 'user1987@example.com'),
(1988, 'User 1988', 'VRP4975210', '1997-03-28', '9716069569', 'user1988@example.com'),
(1989, 'User 1989', 'TMB3269105', '1953-05-27', '7541691977', 'user1989@example.com'),
(1990, 'User 1990', 'WTR8115385', '1953-05-03', '3010889577', 'user1990@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1991, 'User 1991', 'JMZ0992202', '2003-12-14', '0003536191', 'user1991@example.com'),
(1992, 'User 1992', 'LSC8440421', '1992-05-25', '6731863239', 'user1992@example.com'),
(1993, 'User 1993', 'ZKB6452422', '1916-08-05', '3325661321', 'user1993@example.com'),
(1994, 'User 1994', 'ERY2191746', '2003-07-08', '8694477613', 'user1994@example.com'),
(1995, 'User 1995', 'INH1071683', '1955-04-20', '3883613598', 'user1995@example.com');

INSERT INTO voters (id, name, voter_id, dob, phone, email)  VALUES
(1996, 'User 1996', 'VCZ4073373', '1928-03-16', '3354396346', 'user1996@example.com'),
(1997, 'User 1997', 'WVC1096275', '1921-03-03', '7576472541', 'user1997@example.com'),
(1998, 'User 1998', 'LKT1806844', '1926-02-08', '1793938050', 'user1998@example.com'),
(1999, 'User 1999', 'HEU8575704', '2005-04-21', '9431423957', 'user1999@example.com'),
(2000, 'User 2000', 'TCC2632164', '1956-02-27', '2695726284', 'user2000@example.com');


