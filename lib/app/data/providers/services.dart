class Api {
  static const koneksi = "https://a8b0-118-99-83-49.ngrok-free.app/api";
  static const gambar = "https://a8b0-118-99-83-49.ngrok-free.app/";
  static const signUp = "$koneksi/validate/register";
  static const signIn = "$koneksi/validate/login";
  static const signInKurir = "$koneksi/validate/loginKurir";
  static const updateProfile = "$koneksi/validate/customerAccount";
  static const getProfile = '$koneksi/validate/profileShow';
  static const updateFoto = '$koneksi/validate/imageProfile';
  static const semua = "$koneksi/menu/productAll/";
  static const forgotPassword = "$koneksi/validate/forgotPassword";
  static const verifKode = "$koneksi/validate/verifKode";
  static const ubahPassword = "$koneksi/validate/confirmPassword";
  static const makanan = "$koneksi/menu/food/";
  static const minuman = "$koneksi/menu/drink/";
  static const diskon = "$koneksi/menu/productWithDiscount/";
  static const penjualanHariIni = "$koneksi/menu/productBestToday";
  static const riwayat = "$koneksi/transaction/riwayatTransaction/";
  static const pesananProses = "$koneksi/transaction/diproses";
  static const pesananDikirim = "$koneksi/transaction/dikirim";
  static const pesananDiterima = "$koneksi/transaction/diterima";
  static const pesananUntukDikirim = "$koneksi/transaction/untukDikirim";
  static const pesananKonfirmasi = "$koneksi/transaction/konfirmasi";
  static const transaksi = "$koneksi/transaction";
  static const konfirmasi = "$koneksi/transaction/konfirmasiPesanan";
}
