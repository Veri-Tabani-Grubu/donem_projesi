-------------- Kullanýcýlar Tablosu
INSERT INTO KullaniciYonetimi.Kullanýcýlar (Rol, Ýsim, Soyisim, Eposta, Þifre)
VALUES
('Hasta', 'Emine', 'Polat', 'ep.60@example.com', '123456'),
('Hasta', 'Ýlkin', 'Tanýk', 'it.56@example.com', 'abcdef'),
('Saðlýk Profesyoneli', 'Rabia', 'Queen', 'rb.23@example.com', '2323'),
('Hasta Yakýný', 'Hacer', 'Cadirci', 'hcd@example.com', '2323'),
('Saðlýk Profesyoneli', 'Medine', 'Çiçek', 'medi@example.com', '23223');

INSERT INTO KullaniciYonetimi.Kullanýcýlar (Rol, Ýsim, Soyisim, Eposta, Þifre)
VALUES
('Hasta Yakýný', 'magnus', 'carlsen', 'chess@example.com', '2323');

-------------- Hasta Tablosu
INSERT INTO SaglikSistemi.Hasta (Kullanýcý_ID, Cinsiyet, Doðum_Tarihi, Kronik_Hastalýk, Teþhis_Tarihi, Alerjiler)
VALUES
(1, 'Kadýn', '1990-03-15', 'Diyabet', '2015-06-10', 'Penisilin'),
(2, 'Erkek', '1985-11-02', 'Astým', '2012-09-18', 'Polen');


------------- Hasta Yakýný Tablosu
INSERT INTO KullaniciYonetimi.Hasta_Yakýný (Hasta_ID, Kullanýcý_ID, Yakýnlýk_Durumu)
VALUES
(1, 4, 'Anne');

----==bir hasta yakýnýnýn en fazla bir hastasý olabilir. o yüzden bu kod duplicate key value hatasý verecektir
-----çünkü daha önce kullanýcý id 4 olan kiþiyi bir hasta ile iliþkilendirmiþtik.
INSERT INTO KullaniciYonetimi.Hasta_Yakýný (Hasta_ID, Kullanýcý_ID, Yakýnlýk_Durumu)
VALUES
(2, 4, 'Anne');

--ama bir hastanýn birden fazla yakýný olabilir. bu durumda 1 idli hastaya daha önce bir hasta yakýný
-- atamýþtýk fakat yeni bir hasta yakýný daha ekleyebildik.
INSERT INTO KullaniciYonetimi.Hasta_Yakýný (Hasta_ID, Kullanýcý_ID, Yakýnlýk_Durumu)
VALUES
(1, 6, 'Baba');


--------------- Saðlýk Profesyoneli Tablosu
INSERT INTO KullaniciYonetimi.Saðlýk_Profesyoneli (Kullanýcý_ID, Uzmanlýk_Alaný)
VALUES
(3, 'Kardiyoloji'),
(5, 'Onkoloji');

--------------- Ýlaçlar Tablosu
INSERT INTO SaglikSistemi.Ýlaçlar (Ýlaç_Adý, Dozaj, Kullaným_Talimatý, Yan_Etkiler)
VALUES
('Parol', '500 mg', 'Günde 3 kez', 'Baþ dönmesi'),
('Aspirin', '100 mg', 'Yemekten sonra', 'Mide bulantýsý'),
('Metformin', '850 mg', 'Sabah ve akþam', 'Baþ aðrýsý'),
('Ventolin', '100 mcg', 'Günde 2 kez', 'Boðaz kuruluðu'),
('Lipitor', '20 mg', 'Akþam yatmadan önce', 'Kas aðrýsý');

------------- Ýlaç Kullanýmý Tablosu
INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý (Hasta_ID, Ýlaç_ID, Baþlangýç_Tarihi, Bitiþ_Tarihi, Kullaným_Sýklýðý, Son_Kullaným_Tarihi)
VALUES
(6, 1, '2023-01-01', '2023-03-01', 'Günde 3 kez', NULL),
(7, 2, '2022-05-15', '2022-12-15', 'Günde 1 kez', NULL);

----Bir hasta birden fazla ilaç kullanabilir
INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý (Hasta_ID, Ýlaç_ID, Baþlangýç_Tarihi, Bitiþ_Tarihi, Kullaným_Sýklýðý, Son_Kullaným_Tarihi)
VALUES
(1, 2, '2024-01-01', '2023-03-01', 'Günde 3 kez', NULL);

-----bir ilacý da birden fazla hasta kullanabilir
INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý (Hasta_ID, Ýlaç_ID, Baþlangýç_Tarihi, Bitiþ_Tarihi, Kullaným_Sýklýðý, Son_Kullaným_Tarihi)
VALUES
(2, 1, '2024-01-01', '2023-03-01', 'Günde 3 kez', NULL);

     ------------- Saðlýk Profesyoneli-Hasta Tablosu
INSERT INTO SaglikSistemi.Saglik_Profesyoneli_Hasta (Saðlýk_Prof_ID, Hasta_ID, Tarih)
VALUES
(1, 6, '2023-02-01'),
(2, 7, '2023-03-15');

---bir saðlýk profesyonelinin takip ettiði birden fazla hasta olabilir
INSERT INTO SaglikSistemi.Saglik_Profesyoneli_Hasta (Saðlýk_Prof_ID, Hasta_ID, Tarih)
VALUES
(1, 2, '2023-02-01');

---ayný hastayý takip eden birden fazla saðlýk profesyoneli olabilir
INSERT INTO SaglikSistemi.Saglik_Profesyoneli_Hasta (Saðlýk_Prof_ID, Hasta_ID, Tarih)
VALUES
(2, 1, '2023-02-01');


------------ Bildirim Durum Tablosu
INSERT INTO SaglikSistemi.Bildirim_Durum (Bildirim_Durumu)
VALUES
('Tamamlandý'),
('Bekliyor'),
('Ýptal Edildi'),
('Baþarýsýz'),
('Ertelendi');

------------Takvim Bildirimler Tablosu
INSERT INTO SaglikSistemi.Takvim_Bildirimler (Kullaným_Tarihi, Kullaným_Saati, Durum_ID)
VALUES 
('2024-01-01', '08:00:00', 1),
('2024-01-02', '20:00:00', 2);

-----------Ýlaç kullanýmý bildirim tablosu
INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý_Bildirim (Kullaným_ID, Bildirim_ID)
VALUES 
(1, 3);

-----bir ilaç kullanýmý için birden fazla bildirim gönderilebilir
INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý_Bildirim (Kullaným_ID, Bildirim_ID)
VALUES 
(1, 0);

-----bir bildirim/ayni bildirim birden fazla ilaç kullanýmý için gönderilebilir
INSERT INTO SaglikSistemi.Ýlaç_Kullanýmý_Bildirim (Kullaným_ID, Bildirim_ID)
VALUES 
(4, 0);