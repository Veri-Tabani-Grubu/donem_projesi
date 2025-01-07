-- Þema Oluþturma
CREATE SCHEMA KullaniciYonetimi AUTHORIZATION dbo;
CREATE SCHEMA SaglikSistemi AUTHORIZATION dbo;

-- Kullanýcýlar Tablosu
CREATE TABLE KullaniciYonetimi.Kullanýcýlar (
    Kullanýcý_ID INT IDENTITY(1,1) PRIMARY KEY,
    Rol NVARCHAR(50) NOT NULL,
    Ýsim NVARCHAR(100) NOT NULL,
    Soyisim NVARCHAR(100) NOT NULL,
    Eposta NVARCHAR(150) UNIQUE NOT NULL,
    Þifre NVARCHAR(200) NOT NULL
);

-- Hasta Yakýný Tablosu
CREATE TABLE KullaniciYonetimi.Hasta_Yakýný (
    Yakýn_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hasta_ID INT NOT NULL,
	  Kullanýcý_ID INT UNIQUE NOT NULL,
    Yakýnlýk_Durumu NVARCHAR(50),
    FOREIGN KEY (Hasta_ID) REFERENCES SaglikSistemi.Hasta(Hasta_ID),
	FOREIGN KEY (Kullanýcý_ID) REFERENCES KullaniciYonetimi.Kullanýcýlar(Kullanýcý_ID)
);

-- Saðlýk Profesyoneli Tablosu
CREATE TABLE KullaniciYonetimi.Saðlýk_Profesyoneli (
    Saðlýk_Prof_ID INT IDENTITY(1,1) PRIMARY KEY,
    Kullanýcý_ID INT UNIQUE NOT NULL,
    Uzmanlýk_Alaný NVARCHAR(100),
    FOREIGN KEY (Kullanýcý_ID) REFERENCES KullaniciYonetimi.Kullanýcýlar(Kullanýcý_ID)
);

-- Hasta Tablosu
CREATE TABLE SaglikSistemi.Hasta (
    Hasta_ID INT IDENTITY(1,1) PRIMARY KEY,
    Kullanýcý_ID INT UNIQUE NOT NULL,
    Cinsiyet NVARCHAR(10),
    Doðum_Tarihi DATE,
    Kronik_Hastalýk NVARCHAR(255),
    Teþhis_Tarihi DATE,
    Alerjiler NVARCHAR(255),
    FOREIGN KEY (Kullanýcý_ID) REFERENCES KullaniciYonetimi.Kullanýcýlar(Kullanýcý_ID)
);

-- Ýlaçlar Tablosu
CREATE TABLE SaglikSistemi.Ýlaçlar (
    Ýlaç_ID INT IDENTITY(1,1) PRIMARY KEY,
    Ýlaç_Adý NVARCHAR(100) NOT NULL,
    Dozaj NVARCHAR(50),
    Kullaným_Talimatý NVARCHAR(255),
    Yan_Etkiler NVARCHAR(255)
);

-- Ýlaç Kullanýmý Tablosu
CREATE TABLE SaglikSistemi.Ýlaç_Kullanýmý (
    Kullaným_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hasta_ID INT NOT NULL,
    Ýlaç_ID INT NOT NULL,
    Baþlangýç_Tarihi DATE NOT NULL,
    Bitiþ_Tarihi DATE NOT NULL,
    Kullaným_Sýklýðý NVARCHAR(50),
    Son_Kullaným_Tarihi DATE,
    FOREIGN KEY (Hasta_ID) REFERENCES SaglikSistemi.Hasta(Hasta_ID),
    FOREIGN KEY (Ýlaç_ID) REFERENCES SaglikSistemi.Ýlaçlar(Ýlaç_ID)
);


CREATE TABLE SaglikSistemi.Saglik_Profesyoneli_Hasta (
    Saðlýk_Prof_Hasta_ID INT IDENTITY(1,1) PRIMARY KEY,
    Saðlýk_Prof_ID INT NOT NULL,
    Hasta_ID INT NOT NULL,
    Tarih DATE,
    FOREIGN KEY (Saðlýk_Prof_ID) REFERENCES KullaniciYonetimi.Saðlýk_Profesyoneli(Saðlýk_Prof_ID),
    FOREIGN KEY (Hasta_ID) REFERENCES SaglikSistemi.Hasta(Hasta_ID)
);

-- Ara tablo: Ýlaç Kullanýmý ve Bildirim Ýliþkisi
CREATE TABLE SaglikSistemi.Ýlaç_Kullanýmý_Bildirim (
    ID INT IDENTITY(1,1) PRIMARY KEY,        -- Benzersiz kimlik
    Kullaným_ID INT NOT NULL,                -- Ýlaç kullanýmý kimliði
    Bildirim_ID INT NOT NULL,                -- Bildirim kimliði
    FOREIGN KEY (Kullaným_ID) REFERENCES SaglikSistemi.Ýlaç_Kullanýmý(Kullaným_ID),
    FOREIGN KEY (Bildirim_ID) REFERENCES SaglikSistemi.Takvim_Bildirimler(Bildirim_ID)
);

-- Takvim ve Bildirimler Tablosu (zaten normalize edilmiþ)
CREATE TABLE SaglikSistemi.Takvim_Bildirimler (
    Bildirim_ID INT IDENTITY(1,1) PRIMARY KEY,  -- Bildirim kimliði
    Kullaným_Tarihi DATE NOT NULL,              -- Bildirimde belirtilen tarih
    Kullaným_Saati TIME NOT NULL,               -- Bildirimde belirtilen saat
    Durum_ID INT,                               -- Bildirim durumu
    FOREIGN KEY (Durum_ID) REFERENCES SaglikSistemi.Bildirim_Durum(Durum_ID)
);

-- Bildirim Durum Tablosu (zaten normalize edilmiþ)
CREATE TABLE SaglikSistemi.Bildirim_Durum (
    Durum_ID INT IDENTITY(1,1) PRIMARY KEY,  -- Benzersiz kimlik
    Bildirim_Durumu NVARCHAR(50) UNIQUE      -- Bildirimin durumu (ör. tamamlandý, beklemede)
);









