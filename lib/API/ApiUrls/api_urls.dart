class ApiUrls {
  // static const String BASE_URL_dEVELOPMENT = "http://139.5.189.24:8000";
  static const String BASE_URL_dEVELOPMENT = "https://api.farmeasy.co";

  //static const  String FARMER_IMAGE_PATH="http://139.5.189.24:8000/media/user_image/";

  /// SEND_OTP
  static const String SEND_OTP = "$BASE_URL_dEVELOPMENT/user/send_otp/";

  ///VERIFY_OTP
  static const String VERIFY_OTP = "$BASE_URL_dEVELOPMENT/user/verify_otp/";

  ///USER_TYPE
  static const String USER_TYPE =
      "$BASE_URL_dEVELOPMENT/user/update_user_type/";

  ///CREATE_PROFILE
  static const String CREATE_PROFILE =
      "$BASE_URL_dEVELOPMENT/account/create_profile/";

  ///FARMER_EXPERTIES
  static const String FARMER_EXPERTIES =
      "$BASE_URL_dEVELOPMENT/master/list_farmer_expertise_data/";
  static const String FARMER_CROPS =
      "$BASE_URL_dEVELOPMENT/master/list_crop_type/";

  ///AGRI_PROVIDER
  static const String AGRI_PROVIDER =
      "$BASE_URL_dEVELOPMENT/master/list_agri_servicprovider_roles/";

  ///PURPOSE LIST
  static const String PURPOSE_LIST =
      "$BASE_URL_dEVELOPMENT/master/list_land_purpose_data/";

  ///CROP LIST
  static const String CROP_LIST =
      "$BASE_URL_dEVELOPMENT/master/list_crop_type/";
  static const String GET_CROP_LIST =
      "$BASE_URL_dEVELOPMENT/land/list_crops_for_edit_land/?land_id=";

  ///ADD_LAND
  static const String ADD_LAND = "$BASE_URL_dEVELOPMENT/land/add_land/";
  static const String LIST_OTHERS_CROPS =
      "$BASE_URL_dEVELOPMENT/master/get_commodity_list/?search=";

  ///GET_LAND_DETAILS
  static const String GET_LAND_DETAILS =
      "$BASE_URL_dEVELOPMENT/land/get_land_detail/?id=";

  ///MATCHING FARMERS
  static const String GET_MATCHING_FARMER =
      "$BASE_URL_dEVELOPMENT/land/list_matching_farmer/?id=";

  ///MATCHING AGRI PROVIDER
  static const String GET_MATCHING_AGRIPROVIDER =
      "$BASE_URL_dEVELOPMENT/land/list_matching_agri_service_provider/?id=";

  ///LAND LIST
  static const String LAND_LIST = "$BASE_URL_dEVELOPMENT/land/list_land/?page=";
  static const String CROP_SEARCH_DETAILS =
      "$BASE_URL_dEVELOPMENT/master/get_crop_profitability/?land_size=";
  static const String CROP_FERTILIZER_DATA =
      "$BASE_URL_dEVELOPMENT/master/get_crop_fertilizer_data/?crop_id=";
  static const String CALCULATED_FERTILIZER =
      "$BASE_URL_dEVELOPMENT/master/get_crop_fertilizer_requirement/?";
  static const String LIST_USER_REVIEW =
      "$BASE_URL_dEVELOPMENT/account/list_reviews/?user_id=";

  ///IS_USER_EXIST
  static const String IS_USER_EXIST =
      "$BASE_URL_dEVELOPMENT/account/is_profile_exists/";
  static const String FORCE_UPDATE =
      "$BASE_URL_dEVELOPMENT/master/get_app_version/?device=";

  ///ENQUIRIES_LIST
  static const String ENQUIRIES_LIST =
      "$BASE_URL_dEVELOPMENT/enquiry/list_land_enquiry/?id=";

  ///CHECK_LAND_DETAILS
  static const String CHECK_LAND_DETAILS =
      "$BASE_URL_dEVELOPMENT/land/check_land_detail/?id=";

  ///CHECK_LAND_TYPE
  static const String LAND_TYPE =
      "$BASE_URL_dEVELOPMENT/master/list_land_type/";

  ///WATER_RESOURCE
  static const String WATER_RTESOURCE =
      "$BASE_URL_dEVELOPMENT/master/list_water_source/";

  ///LAND_DETAILS_UPDATE
  static const String LAND_DETAILS_UPDATE =
      "$BASE_URL_dEVELOPMENT/land/update_land_detail/?id=";

  ///UPLOAD_LAND_IMAGES
  static const String UPLOAD_LAND_IMAGES =
      "$BASE_URL_dEVELOPMENT/land/upload_land_image/";

  ///DELETE_LAND_IMAGES
  static const String DELETE_LAND_IMAGES =
      "$BASE_URL_dEVELOPMENT/land/delete_land_image/?id=";

  ///UPDATE_LAND_IMAGES
  static const String UPDATE_LAND_IMAGES =
      "$BASE_URL_dEVELOPMENT/land/update_land_id/";

  ///LAND_PERCENTAGE
  static const String LAND_PERCENTAGE =
      "$BASE_URL_dEVELOPMENT/land/get_land_completion_percentage/?id=";

  /// CHAT_DATA
  static const String CHAT_DATA =
      "$BASE_URL_dEVELOPMENT/enquiry/list_messages/?id=";

  ///SEND_MESSAGE
  static const String SEND_MESSGAE =
      "$BASE_URL_dEVELOPMENT/enquiry/post_message/";
  static const String UPDATE_LAND_DETAILS =
      "$BASE_URL_dEVELOPMENT/land/update_land_detail/?id=";

  ///PROFILE_COMPLETE_PERCENTAGE
  static const String PROFILE_COMPLETE_PERCENTAGE =
      "$BASE_URL_dEVELOPMENT/account/get_profile_completion_percentage/";

  ///THREADS_LIST
  static const String THREADS_LIST =
      "$BASE_URL_dEVELOPMENT/thread/list_thread/?tags=";
  static const String PRODUCT_SERVICES =
      "$BASE_URL_dEVELOPMENT/account/list_products/?user_id=";

  ///TAGS_LIST
  static const String TAGS_LIST = "$BASE_URL_dEVELOPMENT/master/list_tags/";
  static const String TAGS_NEW_LIST =
      "$BASE_URL_dEVELOPMENT/master/list_tags_for_filter/";
  static const String THREAD_IMAGE =
      "$BASE_URL_dEVELOPMENT/thread/upload_thread_image/";
  static const String PRODUCT_IMAGE =
      "$BASE_URL_dEVELOPMENT/account/upload_product_image/";
  static const String ADD_MORE_PRODUCTS =
      "$BASE_URL_dEVELOPMENT/account/add_more_product_image/";
  static const String DELETE_THREAD_IMAGE =
      "$BASE_URL_dEVELOPMENT/thread/delete_thread_image/?id=";
  static const String DELETE_PRODUCT_IMAGE =
      "$BASE_URL_dEVELOPMENT/account/delete_product_image/?id=";
  static const String REMOVE_PROFILE_IMAGE =
      "$BASE_URL_dEVELOPMENT/account/remove_photo/";
  static const String CREATE_THREADS =
      "$BASE_URL_dEVELOPMENT/thread/post_thread/";
  static const String ADD_PRODUCT =
      "$BASE_URL_dEVELOPMENT/account/add_product/";
  static const String UPDATE_PRODUCT =
      "$BASE_URL_dEVELOPMENT/account/edit_product/?id=";
  static const String IS_MESSAGE_SEEN =
      "$BASE_URL_dEVELOPMENT/enquiry/mark_message_as_seen/?id=";
  static const String ALL_ENQUIRIES =
      "$BASE_URL_dEVELOPMENT/enquiry/list_all_enquiry/";
  static const String LIKE_UNLIKE_THREAD =
      "$BASE_URL_dEVELOPMENT/thread/like_unlike_thread/";
  static const String PARTICULAR_THREAD =
      "$BASE_URL_dEVELOPMENT/thread/get_thread_detail/?id=";
  static const String DELETE_THREAD =
      "$BASE_URL_dEVELOPMENT/thread/delete_thread/?id=";
  static const String REPLIES_LIST =
      "$BASE_URL_dEVELOPMENT/thread/list_thread_reply/?id=";
  static const String REPLY_THREAD =
      "$BASE_URL_dEVELOPMENT/thread/post_thread_reply/";
  static const String DELETE_PRODUCT =
      "$BASE_URL_dEVELOPMENT/account/delete_product/?id=";
  static const String CURRENT_WEATHER_API =
      "https://api.openweathermap.org/data/2.5/weather?";
  static const String WEATHER_FORECAST =
      "https://api.openweathermap.org/data/2.5/forecast/daily?";
  static const String CROP_SUGGESTION =
      "$BASE_URL_dEVELOPMENT/land/list_crop_suggestion/?land_id=";
  static const String GET_PROFILE_DETAILS =
      "$BASE_URL_dEVELOPMENT/account/get_profile/";
  static const String UPDATE_PROFILE =
      "$BASE_URL_dEVELOPMENT/account/update_profile/";
  static const String RECOMENDED_LANDS =
      "$BASE_URL_dEVELOPMENT/land/list_recommended_land/";
  static const String RECOMENDED_LAND_DETAILS =
      "$BASE_URL_dEVELOPMENT/land/get_recommended_land_detail/?id=";
  static const String AGRI_SERVICE_PROVIDER =
      "$BASE_URL_dEVELOPMENT/account/list_agri_service_provider/?page=";
  static const String LIST_FARMER =
      "$BASE_URL_dEVELOPMENT/account/list_farmer/?page=";
  static const String RECOMMENDED_LANDOWNERS =
      "$BASE_URL_dEVELOPMENT/account/list_near_by_land_owners/";
  static const String LIST_LAND_OWNER =
      "$BASE_URL_dEVELOPMENT/account/list_land_owner/?";
  static const String FOLLOWING_LIST =
      "$BASE_URL_dEVELOPMENT/account/get_following_list/?user_id=";
  static const String FOLLOWERS_LIST =
      "$BASE_URL_dEVELOPMENT/account/get_followers_list/?user_id=";
  static const String LIST_ALL_LAND =
      "$BASE_URL_dEVELOPMENT/land/list_all_lands/?page=";
  static const String LIST_USER_LANDS =
      "$BASE_URL_dEVELOPMENT/land/get_user_land_list/?user_id=";
  static const String USER_DETAILS =
      "$BASE_URL_dEVELOPMENT/account/get_user_detail/?user_id=";
  static const String FCM_TOKEN =
      "$BASE_URL_dEVELOPMENT/user/update_fcm_token/";
  static const String SEARCH_CROP =
      "$BASE_URL_dEVELOPMENT/master/list_crop_for_profitability_calculator/?search=";
  static const String EDUCATION_LIST =
      "$BASE_URL_dEVELOPMENT/master/list_education/?search=";
  static const String FOLLWO_UNFOLLOW =
      "$BASE_URL_dEVELOPMENT/account/follow_unfollow/";
  static const String REVIEW_POST =
      "$BASE_URL_dEVELOPMENT/account/post_review/";
  static const String ADD_FEEDBACK =
      "$BASE_URL_dEVELOPMENT/account/add_feedback/";
  static const String SUGGEST_CROP = "$BASE_URL_dEVELOPMENT/land/list_crops/?";
  static const String ADD_LAND_IMAGES =
      "$BASE_URL_dEVELOPMENT/land/add_more_land_image/";
  static const String PARTNER_SERVICES =
      "$BASE_URL_dEVELOPMENT/master/list_master_services/";
  static const String PARTNER_SERVICES_LIST =
      "$BASE_URL_dEVELOPMENT/master/get_services_list/";
  static const String NEARBY_PARTNER =
      "$BASE_URL_dEVELOPMENT/account/list_near_by_partners/?";
  static const String MARKET_DATA =
      "$BASE_URL_dEVELOPMENT/account/list_commodities_price/";
  static const String MARKET_LIST =
      "$BASE_URL_dEVELOPMENT/master/get_market_list/?search=";
  static const String DISTRICT_LIST =
      "$BASE_URL_dEVELOPMENT/master/get_district_list/?";
  static const String STATE_LIST =
      "$BASE_URL_dEVELOPMENT/master/get_state_list/?search=";
  static const String SEARCH_COMODITY =
      "$BASE_URL_dEVELOPMENT/master/get_commodity_list/?search=";
  static const String REMOVE_CERTIFICATE =
      "$BASE_URL_dEVELOPMENT/land/remove_land_certificate/?land_id=";
  static const String ADD_SERVICABLE_AREA =
      "$BASE_URL_dEVELOPMENT/master/get_serviceable_area_list/";
  static const String DELETE_ACCOUNT =
      "$BASE_URL_dEVELOPMENT/user/delete_user/";
  static const String MARKET_CROP_IMAGE =
      "https://pixabay.com/api/?key=45331935-2200a98827dc6a4782c760582&image_type=photo&page=1&per_page=3&q=";
}
