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

---------=====================----------------
SELECT hy.Yak�n_ID, hy.Yak�nl�k_Durumu, h.Hasta_ID, k.�sim AS Yak�n_�sim, k.Soyisim AS Yak�n_Soyisim
FROM KullaniciYonetimi.Hasta_Yak�n� hy
JOIN SaglikSistemi.Hasta h ON hy.Hasta_ID = h.Hasta_ID
JOIN KullaniciYonetimi.Kullan�c�lar k ON hy.Kullan�c�_ID = k.Kullan�c�_ID;
---------=====================----------------

---------=====================----------------
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
---------=====================----------------

-- Belirli bir hasta yak�n� test et (�rne�in, Hasta_ID 1 ve Kullan�c�_ID 4 olan)
SELECT * FROM KullaniciYonetimi.Hasta_Yak�n�
WHERE Hasta_ID = 1 AND Kullan�c�_ID = 4;

-- Toplam hasta yak�n� say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Hasta_Yak�nlar� FROM KullaniciYonetimi.Hasta_Yak�n�;


     -------- ======Sa�l�k Profesyoneli tablosundaki t�m kay�tlar� g�r�nt�le====------
SELECT * FROM KullaniciYonetimi.Sa�l�k_Profesyoneli;

---------=====================----------------
SELECT sp.Sa�l�k_Prof_ID, k.�sim, k.Soyisim, sp.Uzmanl�k_Alan�
FROM KullaniciYonetimi.Sa�l�k_Profesyoneli sp
JOIN KullaniciYonetimi.Kullan�c�lar k ON sp.Kullan�c�_ID = k.Kullan�c�_ID;
---------=====================----------------

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
---------=====================----------------
SELECT h.Hasta_ID, k.�sim AS Hasta_�sim, i.�la�_Ad�, ik.Ba�lang��_Tarihi, ik.Biti�_Tarihi, ik.Kullan�m_S�kl���
FROM SaglikSistemi.�la�_Kullan�m� ik
JOIN SaglikSistemi.Hasta h ON ik.Hasta_ID = h.Hasta_ID
JOIN KullaniciYonetimi.Kullan�c�lar k ON h.Kullan�c�_ID = k.Kullan�c�_ID
JOIN SaglikSistemi.�la�lar i ON ik.�la�_ID = i.�la�_ID;
---------=====================----------------

---------=====================----------------
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
---------=====================----------------

-- Belirli bir ila� kullan�m�n� test et (�rne�in Hasta_ID 1 ve �la�_ID 1 olan)
SELECT * FROM SaglikSistemi.�la�_Kullan�m�
WHERE Hasta_ID = 1 AND �la�_ID = 1;

-- Toplam ila� kullan�m� say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_�la�_Kullan�mlar� FROM SaglikSistemi.�la�_Kullan�m�;

--Delete from SaglikSistemi.�la�_Kullan�m�
--where Kullan�m_ID=5;


       ----------========= Sa�l�k Profesyoneli-Hasta tablosundaki t�m kay�tlar� g�r�nt�le=====-------
SELECT * FROM SaglikSistemi.Saglik_Profesyoneli_Hasta;

---------=====================----------------
SELECT spk.Sa�l�k_Prof_Hasta_ID, spk.Sa�l�k_Prof_ID, spk.Hasta_ID, k1.�sim AS Profesyonel_�sim, k1.Soyisim AS Profesyonel_Soyisim, 
       k2.�sim AS Hasta_�sim, k2.Soyisim AS Hasta_Soyisim
FROM SaglikSistemi.Saglik_Profesyoneli_Hasta spk
JOIN KullaniciYonetimi.Sa�l�k_Profesyoneli sp ON spk.Sa�l�k_Prof_ID = sp.Sa�l�k_Prof_ID
JOIN KullaniciYonetimi.Kullan�c�lar k1 ON sp.Kullan�c�_ID = k1.Kullan�c�_ID
JOIN SaglikSistemi.Hasta h ON spk.Hasta_ID = h.Hasta_ID
JOIN KullaniciYonetimi.Kullan�c�lar k2 ON h.Kullan�c�_ID = k2.Kullan�c�_ID;
---------=====================----------------

---------=====================----------------
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
---------=====================----------------

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

---------=====================----------------
SELECT tb.Bildirim_ID, tb.Kullan�m_Tarihi, tb.Kullan�m_Saati, bd.Bildirim_Durumu
FROM SaglikSistemi.Takvim_Bildirimler tb
JOIN SaglikSistemi.Bildirim_Durum bd ON tb.Durum_ID = bd.Durum_ID;
---------=====================----------------

---------=====================----------------
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
---------=====================----------------

--delete from SaglikSistemi.Takvim_Bildirimler
--where Bildirim_ID=5;

-- Belirli bir bildirimi test et (�rne�in Kullan�m_ID 1 ve Tarih 2023-01-02 olan)
SELECT * FROM SaglikSistemi.Takvim_Bildirimler
WHERE Kullan�m_ID = 1 AND Kullan�m_Tarihi = '2023-01-02';

-- Toplam takvim bildirimi say�s�n� kontrol et
SELECT COUNT(*) AS Toplam_Takvim_Bildirimleri FROM SaglikSistemi.Takvim_Bildirimler;

 ---------========== �la�_Kullan�m�_Bildirim tablosundaki t�m kay�tlar� g�r�nt�le=======--------

SELECT ikb.ID, ik.Hasta_ID, i.�la�_Ad�, tb.Kullan�m_Tarihi, tb.Kullan�m_Saati, bd.Bildirim_Durumu
FROM SaglikSistemi.�la�_Kullan�m�_Bildirim ikb
JOIN SaglikSistemi.�la�_Kullan�m� ik ON ikb.Kullan�m_ID = ik.Kullan�m_ID
JOIN SaglikSistemi.�la�lar i ON ik.�la�_ID = i.�la�_ID
JOIN SaglikSistemi.Takvim_Bildirimler tb ON ikb.Bildirim_ID = tb.Bildirim_ID
JOIN SaglikSistemi.Bildirim_Durum bd ON tb.Durum_ID = bd.Durum_ID;


---------========== Belirli bir hasta i�in t�m verileri g�r�nt�le=======-----------
SELECT h.Hasta_ID, k.�sim AS Hasta_�sim, k.Soyisim AS Hasta_Soyisim, 
       i.�la�_Ad�, ik.Ba�lang��_Tarihi, ik.Biti�_Tarihi, bd.Bildirim_Durumu
FROM SaglikSistemi.Hasta h
JOIN KullaniciYonetimi.Kullan�c�lar k ON h.Kullan�c�_ID = k.Kullan�c�_ID
JOIN SaglikSistemi.�la�_Kullan�m� ik ON h.Hasta_ID = ik.Hasta_ID
JOIN SaglikSistemi.�la�lar i ON ik.�la�_ID = i.�la�_ID
JOIN SaglikSistemi.�la�_Kullan�m�_Bildirim ikb ON ik.Kullan�m_ID = ikb.Kullan�m_ID
JOIN SaglikSistemi.Takvim_Bildirimler tb ON ikb.Bildirim_ID = tb.Bildirim_ID
JOIN SaglikSistemi.Bildirim_Durum bd ON tb.Durum_ID = bd.Durum_ID
WHERE h.Hasta_ID = 1;
