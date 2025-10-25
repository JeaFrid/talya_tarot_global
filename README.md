# Talya Tarot

Talya Tarot, Google Gemini tarafından desteklenen yapay zekâ yorumlarıyla tarot deneyimi sunan bir Flutter uygulamasıdır. Uygulama; üç kartlık tarot açılımları, burç yorumu, fotoğraf göndererek yorum alma ve topluluk akışı gibi etkileşimli özellikler içerir.

## Özellikler
- **Yapay zekâ tarot yorumları:** Gemini modelleriyle üç kartlık açılımlar ve sohbet tabanlı sorular için kişiselleştirilmiş yanıtlar üretir.
- **Burç yorumu:** Kullanıcının seçtiği burca göre günlük ve yaşa duyarlı kısa yorumlar hazırlar.
- **Fotoğraf yorumu:** Fotoğraf yükleyerek kahve/fotoğraf falı tarzında açıklamalar alma imkânı.
- **Topluluk alanı:** Firebase Realtime Database üzerinden topluluk paylaşımlarını listeleme ve yönetme.
- **Bildirim desteği:** OneSignal entegrasyonu sayesinde push bildirimleri gönderme temelini hazırlar.
- **Kullanıcı tercihleri:** Shared Preferences ile isim, yaş ve geçmiş yorumlar gibi bilgiler lokal olarak saklanır.

## Teknolojiler
- **Flutter 3.5 / Dart 3.5** – Çok platformlu kullanıcı arayüzü.
- **Firebase Core** – Çoklu platform yapılandırması, Realtime Database erişimi ve kimlik doğrulama yardımcıları.
- **Google Generative AI (Gemini)** – Tarot ve burç yorumlarının üretilmesi.
- **OneSignal Flutter** – Push bildirim altyapısı.
- **Shared Preferences & Cosmos paketleri** – Yerel veri saklama, zaman/gezinti yardımcıları ve arayüz bileşenleri.

## Kurulum

### Gereksinimler
- Flutter SDK `3.5.3` ve uyumlu Dart sürümü.
- Firebase projesi (Android için `google-services.json` dosyası).
- OneSignal projesi (uygulama ID’si ve isteğe bağlı REST API anahtarı).
- Google Gemini API anahtarı.
- (Android) İmza için JKS/keystore veya eşdeğer çevre değişkenleri.

### Adımlar
1. Depoyu klonlayın:
   ```bash
   git clone https://github.com/JeaFrid/talya_tarot_global.git
   cd talya_tarot
   ```
2. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```
3. Ortam değişkenlerini ayarlayın:
   ```bash
   cp .env.example .env
   ```
   Aşağıdaki anahtarları doldurun:
   - **Gemini:** `GEMINI_API_KEY`
   - **OneSignal:** `ONESIGNAL_APP_ID`, `ONESIGNAL_REST_API_KEY` (REST anahtarı yalnızca sunucu bildirimleri için gerekir).
   - **Firebase Web:** `FIREBASE_WEB_*` anahtarları
   - **Firebase Android:** `FIREBASE_ANDROID_*` anahtarları
   - **Firebase macOS & Windows:** İlgili `FIREBASE_MACOS_*` ve `FIREBASE_WINDOWS_*` değişkenleri
   - **Android imzası:** `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, `ANDROID_KEYSTORE_PATH`, `ANDROID_KEYSTORE_PASSWORD`
4. Android için Firebase yapılandırmasını ekleyin:
   - `android/app/google-services.json.example` dosyasını kopyalayıp gerçek `android/app/google-services.json` dosyanızla doldurun.
5. Android imzasını ayarlayın:
   - `android/key.properties.example` dosyasını kopyalayıp `android/key.properties` olarak güncelleyin **veya** `.env` dosyasındaki Android anahtarlarını kullanın.

## Uygulamayı Çalıştırma
- Varsayılan cihaz/emülatör:
  ```bash
  flutter run
  ```
- Belirli platformlar:
  ```bash
  flutter run -d android
  flutter run -d ios
  flutter run -d windows
  flutter run -d web
  ```
Platform hedefinizin Flutter tarafından desteklendiğinden ve gerekli araç zincirinin kurulu olduğundan emin olun.

## Ek Notlar
- `.env`, keystore’lar ve Firebase konfigürasyonları `.gitignore` üzerinde yer alır; bu dosyaları paylaşmayın.
- OneSignal ve Firebase entegrasyonlarının çalışması için ilgili panellerde gerekli izin ve ayarların (push bildirimler, API erişimleri vb.) aktif olduğundan emin olun.
- Proje yayınlanmadan önce gerçek kullanıcı verilerini korumak için sadece örnek dosyaları ( `.env.example`, `google-services.json.example`, `key.properties.example`) paylaşın.
