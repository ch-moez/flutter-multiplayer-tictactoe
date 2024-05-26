import 'package:get/get.dart';

class Messages extends Translations {
  static const appTitle = 'appTitle';
  static const hello = 'hello';
  static const change = 'change';

  static const settings = 'Settings';
  static const theme = 'Theme';
  static const themeDark = 'Dark Theme';
  static const lightTheme = 'Light Theme';
  static const changetheme = 'Change Theme';
  static const changethemeMessage = 'Change Theme that you want';
  static const changeLanguage = 'Change Language';
  static const changeLanguageMessage =
      'We speaking with all languages of the world';
  static const receiveNotification = 'Recive Notifications';
  static const receiveNotificationMessage =
      'Receive Notifications that you want';
  static const notification = 'Notifications';
  static const signOut = 'Sign out';
  static const logout = 'logout';
  static const areYouSure = 'Are you sure?';
  static const yes = 'Yes';
  static const no = 'No';
  static const termsAndConditions = 'Terms and Conditions';
  static const aboutUs = 'About Us';
  static const contactUs = 'Contact Us';
  static const email = 'Email';
  static const call = 'Call';
  static const whatsApp = 'WhatsApp';
  static const visitOurWebsite = 'Visit Our Website';
  static const selectImage = 'Select Image';
  static const next = 'Next';
  static const removeBackground = 'Remove Background';
  static const saveImage = 'Save Image';
  static const addNewImage = 'Add New Image';

  //Level of game difficulty
  static const easy = 'Easy';
  static const medium = 'Medium';
  static const hard = 'Hard';
  static const replay = 'Replay';

  static const languageList = ['English', 'Français', 'العربية'];
  static const Map<String, String> languagesList = {
    'en_US': 'English',
    'fr_FR': 'Français',
    'ar_AR': 'العربية',
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          hello: 'Hello World',
          change: 'change language',
          settings: 'Settings',
          easy: 'Easy',
          medium: 'Medium',
          hard: 'Hard',
          theme: 'Theme',
          changetheme: 'Change Theme',
          changethemeMessage: 'Change Theme that you want',
          themeDark: 'Dark Theme',
          lightTheme: 'Light Theme',
          appTitle: 'Flip Card Memory',
          replay: 'Replay',
          changeLanguage: 'Change Language',
          receiveNotification: 'Receive Notifications',
          signOut: 'Sign out',
          logout: 'Logout',
          areYouSure: 'Are you sure?',
          yes: 'Yes',
          no: 'No',
          notification: 'Notifications',
          receiveNotificationMessage: 'Receive Notifications that you want',
          changeLanguageMessage: 'We speaking with all languages of the world',
          termsAndConditions: 'Terms and Conditions',
          aboutUs: 'About Us',
          contactUs: 'Contact Us',
          email: 'Email',
          call: 'Call',
          whatsApp: 'WhatsApp',
          visitOurWebsite: 'Visit Our Website',
          selectImage: 'Select Image',
          next: 'Next',
          removeBackground: 'Remove Background',
          saveImage: 'Save Image',
          addNewImage: 'Add New Image',
        },
        'fr_FR': {
          hello: 'Bonjour',
          change: 'Changement de langue',
          settings: 'Paramètres',
          easy: 'Facile',
          medium: 'Média',
          hard: 'Dur',
          theme: 'Thème',
          changetheme: 'Changer le thème',
          changethemeMessage: 'Changer le thème que vous souhaitez',
          themeDark: 'Thème sombre',
          lightTheme: 'Thème clair',
          appTitle: 'Flip Card Memory',
          replay: 'Rejouer',
          changeLanguage: 'Changer la langue',
          receiveNotification: 'Recevoir des notifications',
          signOut: 'Se deconnecter',
          logout: 'Deconnexion',
          areYouSure: 'Etes-vous sur ?',
          yes: 'Oui',
          no: 'Non',
          notification: 'Notifications',
          receiveNotificationMessage:
              'Recevoir des notifications que vous souhaitez',
          changeLanguageMessage:
              'Nous parlons avec toutes les langues du monde',
          termsAndConditions: 'Termes et conditions',
          aboutUs: 'A propos de nous',
          contactUs: 'Contactez-nous',
          email: 'Email',
          call: 'Appeler',
          whatsApp: 'WhatsApp',
          visitOurWebsite: 'Visitez notre site',
          selectImage: 'Selectionner une image',
          next: 'Suivant',
          removeBackground: 'Supprimer le fond',
          saveImage: 'Enregistrer l\'image',
          addNewImage: 'Ajouter une nouvelle image',
        },
        'ar_AR': {
          hello: 'مرحبا',
          change: 'تغيير اللغة',
          settings: 'الاعدادات',
          easy: 'سهل',
          medium: 'متوسط',
          hard: 'صعب',
          theme: 'المظهر',
          changetheme: 'تغيير المظهر',
          changethemeMessage: 'تغيير المظهر التي تريد',
          themeDark: 'المظهر الداكن',
          lightTheme: 'المظهر الفاتح',
          appTitle: 'Flip Card Memory',
          replay: 'اعادة',
          changeLanguage: 'تغيير اللغة',
          receiveNotification: 'تلقي الاشعارات',
          signOut: 'تسجيل الخروج',
          logout: 'تسجيل الخروج',
          areYouSure: 'هل انت متأكد ؟',
          yes: 'نعم',
          no: 'لا',
          notification: 'الاشعارات',
          receiveNotificationMessage: 'تلقي الاشعارات التي تريد',
          changeLanguageMessage: 'نحن نتحدث مع جميع لغات العالم',
          termsAndConditions: 'الشروط والاحكام',
          aboutUs: 'عنا',
          contactUs: 'اتصل بنا',
          email: 'البريد الالكتروني',
          call: 'اتصال',
          whatsApp: 'WhatsApp',
          visitOurWebsite: 'زيارة موقعنا',
          selectImage: 'تحديد الصورة',
          next: 'التالي',
          removeBackground: 'حذف الخلفية',
          saveImage: 'حفظ الصورة',
          addNewImage: 'اضافة صورة جديدة',
        },
      };
}
