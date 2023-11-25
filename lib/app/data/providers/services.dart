class Api {
  static const koneksi = "https://dee1-103-109-209-254.ngrok-free.app/api";
  static const gambar = "https://dee1-103-109-209-254.ngrok-free.app/";
  static const signUp = "$koneksi/validate/register";
  static const signIn = "$koneksi/validate/login";
  static const updateProfile = "$koneksi/customerAccount";
  static const getProfile = '$koneksi/profileShow';
  static const updateFoto = '$koneksi/imageProfile';
  static const forgotPassword = "$koneksi/validate/forgotPassword";
  static const verifKode = "$koneksi/validate/verifKode";
  static const ubahPassword = "$koneksi/validate/confirmPassword";
  static const semua = "$koneksi/menu/productAll/";
  static const makanan = "$koneksi/menu/food/";
  static const minuman = "$koneksi/menu/drink/";
  static const diskon = "$koneksi/menu/productWithDiscount/";
  static const penjualan_hari_ini = "$koneksi/menu/productBestToday";
  static const riwayat = "$koneksi/transaction/riwayatTransaction/";
  static const pesananProses = "$koneksi/transaction/diproses";
  static const pesananDikirim = "$koneksi/transaction/dikirim";
  static const pesananDiterima = "$koneksi/transaction/diterima";
  static const transaksi = "$koneksi/transaction";
}
