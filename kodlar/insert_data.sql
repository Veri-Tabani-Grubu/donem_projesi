-------------- Kullan�c�lar Tablosu
INSERT INTO KullaniciYonetimi.Kullan�c�lar (Rol, �sim, Soyisim, Eposta, �ifre)
VALUES
('Hasta', 'Emine', 'Polat', 'ep.60@example.com', '123456'),
('Hasta', '�lkin', 'Tan�k', 'it.56@example.com', 'abcdef'),
('Sa�l�k Profesyoneli', 'Rabia', 'Queen', 'rb.23@example.com', '2323'),
('Hasta Yak�n�', 'Hacer', 'Cadirci', 'hcd@example.com', '2323'),
('Sa�l�k Profesyoneli', 'Medine', '�i�ek', 'medi@example.com', '23223');

INSERT INTO KullaniciYonetimi.Kullan�c�lar (Rol, �sim, Soyisim, Eposta, �ifre)
VALUES
('Hasta Yak�n�', 'magnus', 'carlsen', 'chess@example.com', '2323');

-------------- Hasta Tablosu
INSERT INTO SaglikSistemi.Hasta (Kullan�c�_ID, Cinsiyet, Do�um_Tarihi, Kronik_Hastal�k, Te�his_Tarihi, Alerjiler)
VALUES
(1, 'Kad�n', '1990-03-15', 'Diyabet', '2015-06-10', 'Penisilin'),
(2, 'Erkek', '1985-11-02', 'Ast�m', '2012-09-18', 'Polen');


------------- Hasta Yak�n� Tablosu
INSERT INTO KullaniciYonetimi.Hasta_Yak�n� (Hasta_ID, Kullan�c�_ID, Yak�nl�k_Durumu)
VALUES
(1, 4, 'Anne');

----==bir hasta yak�n�n�n en fazla bir hastas� olabilir. o y�zden bu kod duplicate key value hatas� verecektir
-----��nk� daha �nce kullan�c� id 4 olan ki�iyi bir hasta ile ili�kilendirmi�tik.
INSERT INTO KullaniciYonetimi.Hasta_Yak�n� (Hasta_ID, Kullan�c�_ID, Yak�nl�k_Durumu)
VALUES
(2, 4, 'Anne');

--ama bir hastan�n birden fazla yak�n� olabilir. bu durumda 1 idli hastaya daha �nce bir hasta yak�n�
-- atam��t�k fakat yeni bir hasta yak�n� daha ekleyebildik.
INSERT INTO KullaniciYonetimi.Hasta_Yak�n� (Hasta_ID, Kullan�c�_ID, Yak�nl�k_Durumu)
VALUES
(1, 6, 'Baba');


--------------- Sa�l�k Profesyoneli Tablosu
INSERT INTO KullaniciYonetimi.Sa�l�k_Profesyoneli (Kullan�c�_ID, Uzmanl�k_Alan�)
VALUES
(3, 'Kardiyoloji'),
(5, 'Onkoloji');

--------------- �la�lar Tablosu
INSERT INTO SaglikSistemi.�la�lar (�la�_Ad�, Dozaj, Kullan�m_Talimat�, Yan_Etkiler)
VALUES
('Parol', '500 mg', 'G�nde 3 kez', 'Ba� d�nmesi'),
('Aspirin', '100 mg', 'Yemekten sonra', 'Mide bulant�s�'),
('Metformin', '850 mg', 'Sabah ve ak�am', 'Ba� a�r�s�'),
('Ventolin', '100 mcg', 'G�nde 2 kez', 'Bo�az kurulu�u'),
('Lipitor', '20 mg', 'Ak�am yatmadan �nce', 'Kas a�r�s�');

------------- �la� Kullan�m� Tablosu
INSERT INTO SaglikSistemi.�la�_Kullan�m� (Hasta_ID, �la�_ID, Ba�lang��_Tarihi, Biti�_Tarihi, Kullan�m_S�kl���, Son_Kullan�m_Tarihi)
VALUES
(6, 1, '2023-01-01', '2023-03-01', 'G�nde 3 kez', NULL),
(7, 2, '2022-05-15', '2022-12-15', 'G�nde 1 kez', NULL);

----Bir hasta birden fazla ila� kullanabilir
INSERT INTO SaglikSistemi.�la�_Kullan�m� (Hasta_ID, �la�_ID, Ba�lang��_Tarihi, Biti�_Tarihi, Kullan�m_S�kl���, Son_Kullan�m_Tarihi)
VALUES
(1, 2, '2024-01-01', '2023-03-01', 'G�nde 3 kez', NULL);

-----bir ilac� da birden fazla hasta kullanabilir
INSERT INTO SaglikSistemi.�la�_Kullan�m� (Hasta_ID, �la�_ID, Ba�lang��_Tarihi, Biti�_Tarihi, Kullan�m_S�kl���, Son_Kullan�m_Tarihi)
VALUES
(2, 1, '2024-01-01', '2023-03-01', 'G�nde 3 kez', NULL);

     ------------- Sa�l�k Profesyoneli-Hasta Tablosu
INSERT INTO SaglikSistemi.Saglik_Profesyoneli_Hasta (Sa�l�k_Prof_ID, Hasta_ID, Tarih)
VALUES
(1, 6, '2023-02-01'),
(2, 7, '2023-03-15');

---bir sa�l�k profesyonelinin takip etti�i birden fazla hasta olabilir
INSERT INTO SaglikSistemi.Saglik_Profesyoneli_Hasta (Sa�l�k_Prof_ID, Hasta_ID, Tarih)
VALUES
(1, 2, '2023-02-01');

---ayn� hastay� takip eden birden fazla sa�l�k profesyoneli olabilir
INSERT INTO SaglikSistemi.Saglik_Profesyoneli_Hasta (Sa�l�k_Prof_ID, Hasta_ID, Tarih)
VALUES
(2, 1, '2023-02-01');


------------ Bildirim Durum Tablosu
INSERT INTO SaglikSistemi.Bildirim_Durum (Bildirim_Durumu)
VALUES
('Tamamland�'),
('Bekliyor'),
('�ptal Edildi'),
('Ba�ar�s�z'),
('Ertelendi');

------------Takvim Bildirimler Tablosu
INSERT INTO SaglikSistemi.Takvim_Bildirimler (Kullan�m_Tarihi, Kullan�m_Saati, Durum_ID)
VALUES 
('2024-01-01', '08:00:00', 1),
('2024-01-02', '20:00:00', 2);

-----------�la� kullan�m� bildirim tablosu
INSERT INTO SaglikSistemi.�la�_Kullan�m�_Bildirim (Kullan�m_ID, Bildirim_ID)
VALUES 
(1, 3);

-----bir ila� kullan�m� i�in birden fazla bildirim g�nderilebilir
INSERT INTO SaglikSistemi.�la�_Kullan�m�_Bildirim (Kullan�m_ID, Bildirim_ID)
VALUES 
(1, 0);

-----bir bildirim/ayni bildirim birden fazla ila� kullan�m� i�in g�nderilebilir
INSERT INTO SaglikSistemi.�la�_Kullan�m�_Bildirim (Kullan�m_ID, Bildirim_ID)
VALUES 
(4, 0);