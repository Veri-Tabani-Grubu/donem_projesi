-- Kullan�c�lar tablosundaki t�m kay�tlar� g�r�nt�le
SELECT * FROM KullaniciYonetimi.Kullan�c�lar;

-- Belirli bir kullan�c�y� test et (�rne�in Ahmet Y�lmaz)
SELECT * FROM KullaniciYonetimi.Kullan�c�lar
WHERE �sim = 'Ahmet' AND Soyisim = 'Y�lmaz';

-- Toplam kullan�c� say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Kullan�c�lar FROM KullaniciYonetimi.Kullan�c�lar;


      -------- ======Hasta tablosundaki t�m kay�tlar� g�r�nt�le=====------
SELECT * FROM SaglikSistemi.Hasta;

SELECT 
    H.Hasta_ID,
	K.Kullan�c�_ID,
    K.�sim AS Hasta_Ad�,
    K.Soyisim AS Hasta_Soyad�,
    K.Eposta AS Hasta_Eposta,
    H.Cinsiyet,
    H.Do�um_Tarihi,
    H.Kronik_Hastal�k,
    H.Te�his_Tarihi,
    H.Alerjiler
FROM 
    SaglikSistemi.Hasta H
JOIN 
    KullaniciYonetimi.Kullan�c�lar K
ON 
    H.Kullan�c�_ID = K.Kullan�c�_ID;

-- Belirli bir hastay� test et 
SELECT * FROM SaglikSistemi.Hasta
WHERE Kullan�c�_ID = 2;

-- Toplam hasta say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Hastalar FROM SaglikSistemi.Hasta;


-----------========= Hasta Yak�n� tablosundaki t�m kay�tlar� g�r�nt�le========------------
SELECT * FROM KullaniciYonetimi.Hasta_Yak�n�;

SELECT 
    HY.Yak�n_ID,
    H.Hasta_ID,
    HastaK.�sim AS Hasta_Ad�,
    HastaK.Soyisim AS Hasta_Soyad�,
    Yak�nK.�sim AS Yak�n_Ad�,
    Yak�nK.Soyisim AS Yak�n_Soyad�,
    HY.Yak�nl�k_Durumu
FROM 
    KullaniciYonetimi.Hasta_Yak�n� HY
JOIN 
    SaglikSistemi.Hasta H
ON 
    HY.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar HastaK
ON 
    H.Kullan�c�_ID = HastaK.Kullan�c�_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar Yak�nK
ON 
    HY.Kullan�c�_ID = Yak�nK.Kullan�c�_ID;

-- Belirli bir hasta yak�n� test et (�rne�in, Hasta_ID 1 ve Kullan�c�_ID 4 olan)
SELECT * FROM KullaniciYonetimi.Hasta_Yak�n�
WHERE Hasta_ID = 1 AND Kullan�c�_ID = 4;

-- Toplam hasta yak�n� say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Hasta_Yak�nlar� FROM KullaniciYonetimi.Hasta_Yak�n�;


     -------- ======Sa�l�k Profesyoneli tablosundaki t�m kay�tlar� g�r�nt�le====------
SELECT * FROM KullaniciYonetimi.Sa�l�k_Profesyoneli;

SELECT 
    SPH.Sa�l�k_Prof_Hasta_ID as Takip_ID,
    SP.Sa�l�k_Prof_ID,
    SPK.�sim AS Sa�l�k_Profesyoneli_Ad�,
    SPK.Soyisim AS Sa�l�k_Profesyoneli_Soyad�,
    H.Hasta_ID,
    HastaK.�sim AS Hasta_Ad�,
    HastaK.Soyisim AS Hasta_Soyad�,
    SPH.Tarih
FROM 
    SaglikSistemi.Saglik_Profesyoneli_Hasta SPH
JOIN 
    KullaniciYonetimi.Sa�l�k_Profesyoneli SP
ON 
    SPH.Sa�l�k_Prof_ID = SP.Sa�l�k_Prof_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar SPK
ON 
    SP.Kullan�c�_ID = SPK.Kullan�c�_ID
JOIN 
    SaglikSistemi.Hasta H
ON 
    SPH.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar HastaK
ON 
    H.Kullan�c�_ID = HastaK.Kullan�c�_ID;

-- Belirli bir sa�l�k profesyonelini test et (�rne�in Uzmanl�k Alan� Kardiyoloji olan)
SELECT * FROM KullaniciYonetimi.Sa�l�k_Profesyoneli
WHERE Uzmanl�k_Alan� = 'Kardiyoloji';

-- Toplam sa�l�k profesyoneli say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Sa�l�k_Profesyonelleri FROM KullaniciYonetimi.Sa�l�k_Profesyoneli;


------------========= �la�lar tablosundaki t�m kay�tlar� g�r�nt�le==========---------
SELECT * FROM SaglikSistemi.�la�lar;

-- Belirli bir ilac� test et (�rne�in Parol)
SELECT * FROM SaglikSistemi.�la�lar
WHERE �la�_Ad� = 'Parol';

-- Toplam ila� say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_�la�lar FROM SaglikSistemi.�la�lar;


     ----------------=========== �la� Kullan�m� tablosundaki t�m kay�tlar� g�r�nt�le========-----------
SELECT * FROM SaglikSistemi.�la�_Kullan�m�;

SELECT 
    IK.Kullan�m_ID,
    H.Hasta_ID,
    K.�sim AS Hasta_Ad�,
    K.Soyisim AS Hasta_Soyad�,
	I.�la�_ID,
    I.�la�_Ad�,
    IK.Ba�lang��_Tarihi,
    IK.Biti�_Tarihi,
    IK.Kullan�m_S�kl���,
    IK.Son_Kullan�m_Tarihi
FROM 
    SaglikSistemi.�la�_Kullan�m� IK
JOIN 
    SaglikSistemi.Hasta H
ON 
    IK.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar K
ON 
    H.Kullan�c�_ID = K.Kullan�c�_ID
JOIN 
    SaglikSistemi.�la�lar I
ON 
    IK.�la�_ID = I.�la�_ID;

-- Belirli bir ila� kullan�m�n� test et (�rne�in Hasta_ID 1 ve �la�_ID 1 olan)
SELECT * FROM SaglikSistemi.�la�_Kullan�m�
WHERE Hasta_ID = 1 AND �la�_ID = 1;

-- Toplam ila� kullan�m� say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_�la�_Kullan�mlar� FROM SaglikSistemi.�la�_Kullan�m�;


       ----------========= Sa�l�k Profesyoneli-Hasta tablosundaki t�m kay�tlar� g�r�nt�le=====-------
SELECT * FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;

SELECT 
    SPH.Sa�l�k_Prof_Hasta_ID AS ID,
    SP.Sa�l�k_Prof_ID AS Doktor_ID,
    DoktorK.�sim AS Doktor_Ad�,
    DoktorK.Soyisim AS Doktor_Soyad�,
    H.Hasta_ID AS Hasta_ID,
    HastaK.�sim AS Hasta_Ad�,
    HastaK.Soyisim AS Hasta_Soyad�,
    SPH.Tarih AS G�r��me_Tarihi
FROM 
    SaglikSistemi.Saglik_Profesyoneli_Hasta SPH
JOIN 
    KullaniciYonetimi.Sa�l�k_Profesyoneli SP
ON 
    SPH.Sa�l�k_Prof_ID = SP.Sa�l�k_Prof_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar DoktorK
ON 
    SP.Kullan�c�_ID = DoktorK.Kullan�c�_ID
JOIN 
    SaglikSistemi.Hasta H
ON 
    SPH.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar HastaK
ON 
    H.Kullan�c�_ID = HastaK.Kullan�c�_ID;

-- Belirli bir ili�kiyi test et (�rne�in Sa�l�k_Prof_ID 1 ve Hasta_ID 1 olan)
SELECT * FROM SaglikSistemi.Saglik_Profesyoneli_Hasta
WHERE Sa�l�k_Prof_ID = 1 AND Hasta_ID = 1;

-- Toplam ili�ki say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_�li�kiler FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;


   ----------==========Bildirim Durum tablosundaki t�m kay�tlar� g�r�nt�le========-----
SELECT * FROM SaglikSistemi.Bildirim_Durum;

-- Belirli bir bildirim durumunu test et (�rne�in Tamamland�)
SELECT * FROM SaglikSistemi.Bildirim_Durum
WHERE Bildirim_Durumu = 'Tamamland�';

-- Toplam bildirim durumu say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Bildirim_Durumlar� FROM SaglikSistemi.Bildirim_Durum;


 ---------========== Takvim Bildirimler tablosundaki t�m kay�tlar� g�r�nt�le=======--------
SELECT * FROM SaglikSistemi.Takvim_Bildirimler;

SELECT 
    TB.Bildirim_ID AS Bildirim_ID,
    TB.Kullan�m_Tarihi AS Kullan�m_Tarihi,
    TB.Kullan�m_Saati AS Kullan�m_Saati,
    TB.Durum_ID AS Durum_ID,
    BD.Bildirim_Durumu AS Durum_Bilgisi,
    IK.Hasta_ID AS Hasta_ID,
    K.�sim AS Hasta_Ad�,
    K.Soyisim AS Hasta_Soyad�,
    IK.�la�_ID AS �la�_ID,
    I.�la�_Ad� AS �la�_Ad�
FROM 
    SaglikSistemi.Takvim_Bildirimler TB
JOIN 
    SaglikSistemi.�la�_Kullan�m� IK
ON 
    TB.Kullan�m_ID = IK.Kullan�m_ID
JOIN 
    SaglikSistemi.Hasta H
ON 
    IK.Hasta_ID = H.Hasta_ID
JOIN 
    KullaniciYonetimi.Kullan�c�lar K
ON 
    H.Kullan�c�_ID = K.Kullan�c�_ID
JOIN 
    SaglikSistemi.�la�lar I
ON 
    IK.�la�_ID = I.�la�_ID
LEFT JOIN 
    SaglikSistemi.Bildirim_Durum BD
ON 
    TB.Durum_ID = BD.Durum_ID;

-- Belirli bir bildirimi test et (�rne�in Kullan�m_ID 1 ve Tarih 2023-01-02 olan)
SELECT * FROM SaglikSistemi.Takvim_Bildirimler
WHERE Kullan�m_ID = 1 AND Kullan�m_Tarihi = '2023-01-02';

-- Toplam takvim bildirimi say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Takvim_Bildirimleri FROM SaglikSistemi.Takvim_Bildirimler;
