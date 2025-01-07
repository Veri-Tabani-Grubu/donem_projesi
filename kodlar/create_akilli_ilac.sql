-- �ema Olu�turma
CREATE SCHEMA KullaniciYonetimi AUTHORIZATION dbo;
CREATE SCHEMA SaglikSistemi AUTHORIZATION dbo;

-- Kullan�c�lar Tablosu
CREATE TABLE KullaniciYonetimi.Kullan�c�lar (
    Kullan�c�_ID INT IDENTITY(1,1) PRIMARY KEY,
    Rol NVARCHAR(50) NOT NULL,
    �sim NVARCHAR(100) NOT NULL,
    Soyisim NVARCHAR(100) NOT NULL,
    Eposta NVARCHAR(150) UNIQUE NOT NULL,
    �ifre NVARCHAR(200) NOT NULL
);

-- Hasta Yak�n� Tablosu
CREATE TABLE KullaniciYonetimi.Hasta_Yak�n� (
    Yak�n_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hasta_ID INT NOT NULL,
	  Kullan�c�_ID INT UNIQUE NOT NULL,
    Yak�nl�k_Durumu NVARCHAR(50),
    FOREIGN KEY (Hasta_ID) REFERENCES SaglikSistemi.Hasta(Hasta_ID),
	FOREIGN KEY (Kullan�c�_ID) REFERENCES KullaniciYonetimi.Kullan�c�lar(Kullan�c�_ID)
);

-- Sa�l�k Profesyoneli Tablosu
CREATE TABLE KullaniciYonetimi.Sa�l�k_Profesyoneli (
    Sa�l�k_Prof_ID INT IDENTITY(1,1) PRIMARY KEY,
    Kullan�c�_ID INT UNIQUE NOT NULL,
    Uzmanl�k_Alan� NVARCHAR(100),
    FOREIGN KEY (Kullan�c�_ID) REFERENCES KullaniciYonetimi.Kullan�c�lar(Kullan�c�_ID)
);

-- Hasta Tablosu
CREATE TABLE SaglikSistemi.Hasta (
    Hasta_ID INT IDENTITY(1,1) PRIMARY KEY,
    Kullan�c�_ID INT UNIQUE NOT NULL,
    Cinsiyet NVARCHAR(10),
    Do�um_Tarihi DATE,
    Kronik_Hastal�k NVARCHAR(255),
    Te�his_Tarihi DATE,
    Alerjiler NVARCHAR(255),
    FOREIGN KEY (Kullan�c�_ID) REFERENCES KullaniciYonetimi.Kullan�c�lar(Kullan�c�_ID)
);

-- �la�lar Tablosu
CREATE TABLE SaglikSistemi.�la�lar (
    �la�_ID INT IDENTITY(1,1) PRIMARY KEY,
    �la�_Ad� NVARCHAR(100) NOT NULL,
    Dozaj NVARCHAR(50),
    Kullan�m_Talimat� NVARCHAR(255),
    Yan_Etkiler NVARCHAR(255)
);

-- �la� Kullan�m� Tablosu
CREATE TABLE SaglikSistemi.�la�_Kullan�m� (
    Kullan�m_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hasta_ID INT NOT NULL,
    �la�_ID INT NOT NULL,
    Ba�lang��_Tarihi DATE NOT NULL,
    Biti�_Tarihi DATE NOT NULL,
    Kullan�m_S�kl��� NVARCHAR(50),
    Son_Kullan�m_Tarihi DATE,
    FOREIGN KEY (Hasta_ID) REFERENCES SaglikSistemi.Hasta(Hasta_ID),
    FOREIGN KEY (�la�_ID) REFERENCES SaglikSistemi.�la�lar(�la�_ID)
);


CREATE TABLE SaglikSistemi.Saglik_Profesyoneli_Hasta (
    Sa�l�k_Prof_Hasta_ID INT IDENTITY(1,1) PRIMARY KEY,
    Sa�l�k_Prof_ID INT NOT NULL,
    Hasta_ID INT NOT NULL,
    Tarih DATE,
    FOREIGN KEY (Sa�l�k_Prof_ID) REFERENCES KullaniciYonetimi.Sa�l�k_Profesyoneli(Sa�l�k_Prof_ID),
    FOREIGN KEY (Hasta_ID) REFERENCES SaglikSistemi.Hasta(Hasta_ID)
);

-- Ara tablo: �la� Kullan�m� ve Bildirim �li�kisi
CREATE TABLE SaglikSistemi.�la�_Kullan�m�_Bildirim (
    ID INT IDENTITY(1,1) PRIMARY KEY,        -- Benzersiz kimlik
    Kullan�m_ID INT NOT NULL,                -- �la� kullan�m� kimli�i
    Bildirim_ID INT NOT NULL,                -- Bildirim kimli�i
    FOREIGN KEY (Kullan�m_ID) REFERENCES SaglikSistemi.�la�_Kullan�m�(Kullan�m_ID),
    FOREIGN KEY (Bildirim_ID) REFERENCES SaglikSistemi.Takvim_Bildirimler(Bildirim_ID)
);

-- Takvim ve Bildirimler Tablosu (zaten normalize edilmi�)
CREATE TABLE SaglikSistemi.Takvim_Bildirimler (
    Bildirim_ID INT IDENTITY(1,1) PRIMARY KEY,  -- Bildirim kimli�i
    Kullan�m_Tarihi DATE NOT NULL,              -- Bildirimde belirtilen tarih
    Kullan�m_Saati TIME NOT NULL,               -- Bildirimde belirtilen saat
    Durum_ID INT,                               -- Bildirim durumu
    FOREIGN KEY (Durum_ID) REFERENCES SaglikSistemi.Bildirim_Durum(Durum_ID)
);

-- Bildirim Durum Tablosu (zaten normalize edilmi�)
CREATE TABLE SaglikSistemi.Bildirim_Durum (
    Durum_ID INT IDENTITY(1,1) PRIMARY KEY,  -- Benzersiz kimlik
    Bildirim_Durumu NVARCHAR(50) UNIQUE      -- Bildirimin durumu (�r. tamamland�, beklemede)
);









