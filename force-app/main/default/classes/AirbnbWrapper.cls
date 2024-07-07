public class AirbnbWrapper{
	public data data {get;set;}
	public variables variables;
	public class data {
		public presentation presentation;
	}
	public class presentation {
		public String x_typename;	//RootPresentationContainer
		public stayProductDetailPage stayProductDetailPage;
	}
	public class stayProductDetailPage {
		public String x_typename;	//StayPDPPresentationContainer
		public sections sections;
	}
	public class sections {
        public sbuiData sbuiData;
        public sectionData sectionData;
	}
	public class errors {
	}
	public class sectionDependencies {
	}
	public class enableDependencies {
	}
	public class disableDependencies {
	}
	public class loggingData {
		public String x_typename;	//LoggingEventData
		public String loggingId;	//pdp.overview_default_v2
		public experiments experiments;
		public eventData eventData;
		public String eventDataSchemaName;	//Pdp.v5.ClientEventData
		public section section;
		public component component;
	}
	public class experiments {
	}
	public class eventData {
		public String productId;	//U3RheUxpc3Rpbmc6NDcyMTM5MDQ=
		public String pdpImpressionId;	//p3_1717998010_P3DglOUmWbaaYpnD
		public pdpContext pdpContext;
	}
	public class eventDataSchemaName {
	}
	public class section {
	}
	public class component {
	}
	public class e2eLoggingSession {
	}
	public class mutationMetadata {
	}
	public class button {
	}
	public class BasicButtonFragment {
	}
	public class icon {
	}
	public class mediaItem {
		public String x_typename;	//Image
		public String id;	//SW1hZ2U6d2hhdF9jb3VudHNfYXNfYV9wZXQ=
		public aspectRatio aspectRatio;
		public orientation orientation;
		public onPressAction onPressAction;
		public String accessibilityLabel;	//A guest with a service animal being greeted by a Host
		public String baseUrl;	//https://a0.muscache.com/pictures/adafb11b-41e9-49d3-908e-049dfd6934b6.jpg
		public displayAspectRatio displayAspectRatio;
		public imageMetadata imageMetadata;
		public String previewEncodedPng;	//https://a0.muscache.com/pictures/adafb11b-41e9-49d3-908e-049dfd6934b6.jpg
		public overlay overlay;
		public loggingEventData loggingEventData;
	}
	public class aspectRatio {
	}
	public class orientation {
	}
	public class onPressAction {
	}
	public class displayAspectRatio {
	}
	public class imageMetadata {
	}
	public class overlay {
	}
	public class loggingEventData {
		public String x_typename;	//LoggingEventData
		public String loggingId;	//pdp.overview_default_v2
		public eventData eventData;
		public String eventDataSchemaName;	//Pdp.v5.ClientEventData
		public section section;
		public component component;
	}
	public class subtitle {
	}
	public class subtitleStyle {
	}
	public class titleStyle {
	}
	public class headingLevel {
	}
	public class html {
		public String x_typename;	//Html
		public String htmlText;	//Service animals aren’t pets, so there’s no need to add them here.<br><br>Travelling with an emotional support animal? Check out our <a href="https://www.airbnb.com/help/article/1869/assistance-animals" target="_blank">accessibility policy</a>.
		public readMoreButton readMoreButton;
		public textStyle textStyle;
		public recommendedNumberOfLines recommendedNumberOfLines;
		public minimumNumberOfLinesForTruncation minimumNumberOfLinesForTruncation;
	}
	public class readMoreButton {
	}
	public class textStyle {
	}
	public class recommendedNumberOfLines {
	}
	public class minimumNumberOfLinesForTruncation {
	}
	public class kickerBadge {
	}
	public class sectionsV2 {
	}
	public class screens {
		public String x_typename;	//ScreenContainer
		public String screenId;	//WHAT_COUNTS_AS_A_PET_MODAL
		public screenProperties screenProperties;
		public e2eLoggingSessions e2eLoggingSessions;
		public String screenContentStatus;	//COMPLETE
		public screenContext screenContext;
		public onLoadScreenAction onLoadScreenAction;
		public sectionPlacements[] sectionPlacements;
	}
	public class screenProperties {
		public String x_typename;	//ScreenProperties
		public String modalType;	//CONTEXT_SHEET
		public transitionType transitionType;
		public String modalTitle;	//Service animals
		public unstyled unstyled;
	}
	public class transitionType {
	}
	public class unstyled {
	}
	public class e2eLoggingSessions {
	}
	public class screenContext {
	}
	public class onLoadScreenAction {
	}
	public class sectionPlacements {
		public String x_typename;	//SectionPlacement
		public String placement;	//MAIN
		public String layout;	//SINGLE_COLUMN
		public sectionDetails[] sectionDetails;
		public style style;
		public String formFactor;	//WIDE
		public mediaType mediaType;
	}
	public class sectionDetails {
		public String x_typename;	//SectionDetail
		public String sectionId;	//WHAT_COUNTS_AS_A_PET_MODAL
		public divider divider;
		public border border;
		public topMarginPoints topMarginPoints;
		public Integer topPaddingPoints;	//0
		public Integer bottomPaddingPoints;	//0
		public bottomMarginPoints bottomMarginPoints;
		public backgroundColorNew backgroundColorNew;
		public String horizontalPadding;	//FULL_WIDTH
		public maxWidth maxWidth;
	}
	public class divider {
		public String x_typename;	//Divider
		public String lineStyle;	//NONE
		public lineWidth lineWidth;
		public lineColor lineColor;
		public topPadding topPadding;
		public paddingBelowDivider paddingBelowDivider;
	}
	public class lineWidth {
	}
	public class lineColor {
	}
	public class topPadding {
	}
	public class paddingBelowDivider {
	}
	public class border {
	}
	public class topMarginPoints {
	}
	public class bottomMarginPoints {
	}
	public class backgroundColorNew {
	}
	public class maxWidth {
	}
	public class style {
	}
	public class mediaType {
	}
	public class screensV2 {
	}
	public class flows {
	}
	public class metadata {
		public String x_typename;	//StayPDPMetadata
		public String pdpType;	//MARKETPLACE
		public String pdpUrlType;	//ROOMS
		public pageTitle pageTitle;
		public misaId misaId;
		public boolean isElvisListing;
		public errorData errorData;
		public sharingConfig sharingConfig;
		public loggingContext loggingContext;
		public clientLoggingContext clientLoggingContext;
		public seoFeatures seoFeatures;
		public initialTranslationState initialTranslationState;
		public bookingPrefetchData bookingPrefetchData;
	}
	public class pageTitle {
	}
	public class misaId {
	}
	public class errorData {
	}
	public class sharingConfig {
		public String x_typename;	//PdpSharingConfig
		public String title;	//Hut in Munnar · ★4.84 · 1 bedroom · 1 bed · 1 private bathroom
		public String propertyType;	//Private room in hut
		public String location;	//Munnar
		public Integer personCapacity;	//2
		public String imageUrl;	//https://a0.muscache.com/pictures/0df746f7-086f-4fff-ab79-0038f2c51b1b.jpg
		public String pdpLink;	//https://www.airbnb.co.in/rooms/47213904
		public String shareUrl;	//https://www.airbnb.co.in/rooms/47213904?viralityEntryPoint=1&s=76
		public Integer reviewCount;	//70
		public Double starRating;	//4.84
	}
	public class loggingContext {
		public String x_typename;	//PdpLoggingContext
		public eventDataLogging eventDataLogging;
	}
	public class eventDataLogging {
		public String x_typename;	//PdpEventData
		public String listingId;	//47213904
		public String page;	//p3
		public Integer pdpPageType;	//1
		public Double listingLat;	//9.98574
		public Double listingLng;	//77.04451
		public Integer homeTier;	//1
		public bedType bedType;
		public String roomType;	//Private room
		public Integer personCapacity;	//2
		public String descriptionLanguage;	//en
		public boolean isSuperhost;
		public Integer pictureCount;	//10
		public Integer utcOffset;	//19800
		public amenities[] amenities;
		public Double accuracyRating;	//4.81
		public Double checkinRating;	//4.87
		public Double cleanlinessRating;	//4.81
		public Double communicationRating;	//4.99
		public Double locationRating;	//4.81
		public Double valueRating;	//4.8
		public Double guestSatisfactionOverall;	//4.84
		public String visibleReviewCount;	//70
	}
	public class bedType {
	}
	public class amenities {
	}
	public class clientLoggingContext {
		public String x_typename;	//StayPDPLoggingContext
		public String productId;	//47213904
		public String pdpType;	//MARKETPLACE
		public staysData staysData;
		// public guestCheckoutSteps[] guestCheckoutSteps;
	}
	public class staysData {
	}
	// public class guestCheckoutSteps {
	// 	public String 0;	//T
	// 	public String 1;	//U
	// 	public String 2;	//R
	// 	public String 3;	//N
	// 	public String 4;	//_
	// 	public String 5;	//T
	// 	public String 6;	//H
	// 	public String 7;	//I
	// 	public String 8;	//N
	// 	public String 9;	//G
	// 	public String 10;	//S
	// 	public String 11;	//_
	// 	public String 12;	//O
	// 	public String 13;	//F
	// 	public String 14;	//F
	// }
	public class seoFeatures {
		public String x_typename;	//SeoFeatures
		public String androidAlternateUrl;	//android-app://com.airbnb.android/airbnb/rooms/47213904
		public String androidDeeplink;	//airbnb://rooms/47213904
		public String canonicalUrl;	//https://www.airbnb.co.in/rooms/47213904
		public String iphoneDeeplink;	//airbnb://rooms/47213904
		public String metaDescription;	//11 Jun 2024 - Private room in hut for ₹3378. Welcome to View-Topia, a unique getaway in the middle of nature.🍃  There are two self-build houses: a treehouse and a mudhouse. View-Topia is a sp...
		public String title;	//View-Topia Treehouse - Huts for Rent in Munnar, Kerala, India - Airbnb
		public breadcrumbDetails[] breadcrumbDetails;
		public nearbyCities[] nearbyCities;
		public neighborhoodBreadcrumbDetails[] neighborhoodBreadcrumbDetails;
		public ogTags ogTags;
		public otherPropertyTypes[] otherPropertyTypes;
		public String propertySearchUrl;	///munnar-india/stays
		public String relImageSrc;	//https://a0.muscache.com/im/pictures/89565da2-41b0-443f-84a6-62930398d3cd.jpg?im_w=720&width=720&quality=70&auto=webp
		public twitterTags twitterTags;
		public boolean indexInSearchEngines;
	}
	public class breadcrumbDetails {
		public String x_typename;	//SeoBreadcrumbDetails
		public String linkRoute;	///munnar-india/stays
		public String linkText;	//Munnar
		public String searchText;	//Munnar, India
	}
	public class nearbyCities {
	}
	public class neighborhoodBreadcrumbDetails {
		public String x_typename;	//SeoBreadcrumbDetails
		public String linkRoute;	///munnar-india/stays
		public String linkText;	//Munnar
		public String searchText;	//Munnar, India
	}
	public class ogTags {
		public String x_typename;	//SeoOgTags
		public String ogDescription;	//View-Topia Treehouse
		public String ogImage;	//https://a0.muscache.com/im/pictures/89565da2-41b0-443f-84a6-62930398d3cd.jpg?im_w=720&width=720&quality=70&auto=webp
		public String ogTitle;	//Hut in Munnar · ★4.84 · 1 bedroom · 1 bed · 1 private bathroom
		public String ogType;	//airbedandbreakfast:listing
		public String ogUrl;	//https://www.airbnb.co.in/rooms/47213904
		public ogImageHeight ogImageHeight;
		public ogImageWidth ogImageWidth;
		public ogVideoUrl ogVideoUrl;
		public ogVideoHeight ogVideoHeight;
		public ogVideoWidth ogVideoWidth;
	}
	public class ogImageHeight {
	}
	public class ogImageWidth {
	}
	public class ogVideoUrl {
	}
	public class ogVideoHeight {
	}
	public class ogVideoWidth {
	}
	public class otherPropertyTypes {
		public String x_typename;	//SeoOtherPropertyType
		public String id;	//U2VvT3RoZXJQcm9wZXJ0eVR5cGU6NDcyMTM5MDM=
		public String option;	//Flats
		public String url;	///s/Munnar--India/homes?property_type_id[]=1
	}
	public class twitterTags {
		public String x_typename;	//SeoTwitterTags
		public String twitterCard;	//photo
		public twitterDescription twitterDescription;
		public String twitterImage;	//https://a0.muscache.com/im/pictures/89565da2-41b0-443f-84a6-62930398d3cd.jpg?im_w=720&width=720&quality=70&auto=webp
		public twitterTitle twitterTitle;
		public String twitterUrl;	//https://www.airbnb.co.in/rooms/47213904
	}
	public class twitterDescription {
	}
	public class twitterTitle {
	}
	public class initialTranslationState {
	}
	public class bookingPrefetchData {
		public String x_typename;	//PdpBookingPrefetchData
		public boolean isHotelRatePlanEnabled;
		public tpointContent tpointContent;
		public barPrice barPrice;
		public boolean canInstantBook;
		public cancellationPolicies[] cancellationPolicies;
		public p3DepositData p3DepositData;
		public p3MessageData p3MessageData;
		public p3CancellationSection p3CancellationSection;
		public price price;
		public productRateSections productRateSections;
		public p3_display_rate p3_display_rate;
		public productItemDetail productItemDetail;
		public ratePlanLoggingEventData ratePlanLoggingEventData;
	}
	public class tpointContent {
	}
	public class barPrice {
	}
	public class cancellationPolicies {
		public String x_typename;	//LegacyPdpCancellationSection
		public String cancellation_policy_price_type;	//TIERED_PRICING_FLEXIBLE
		public String book_it_module_tooltip;	//This reservation is non-refundable.
		public Integer cancellation_policy_id;	//44
		public String link;	///help/article/2637
		public String link_text;	//Get full details
		public String localized_cancellation_policy_name;	//Strict
		public milestones[] milestones;
		public subtitles[] subtitles;
		public String title;	//
	}
	public class milestones {
	}
	public class subtitles {
	}
	public class p3DepositData {
	}
	public class p3MessageData {
	}
	public class p3CancellationSection {
		public String x_typename;	//LegacyPdpCancellationSection
		public cancellationPolicyPriceType cancellationPolicyPriceType;
	}
	public class cancellationPolicyPriceType {
	}
	public class price {
	}
	public class productRateSections {
	}
	public class p3_display_rate {
	}
	public class productItemDetail {
	}
	public class ratePlanLoggingEventData {
		public String x_typename;	//LoggingEventData
		public String loggingId;	//ratePlanInput
		public experiments experiments;
		public eventData eventData;
		public eventDataSchemaName eventDataSchemaName;
		public section section;
		public component component;
	}
	public class sbuiData {
		public String x_typename;	//StayPDPSBUIData
		public sectionConfiguration sectionConfiguration;
	}
	public class sectionConfiguration {
		public String x_typename;	//StayPDPSectionConfiguration
		public root root;
		public aircover aircover;
	}
	public class root {
		public String x_typename;	//PlacementGroupsPerFormFactor
		public sections[] sections;
	}
	public class pdpContext {
		public String isGuestFavorite;	//false
	}
	public class sectionData {
		public String x_typename;	//PdpOverviewV2Section
		public String title;	//Private room in hut in Munnar, India
		public overviewItems[] overviewItems;
		public reviewData reviewData;
	}
	public class overviewItems {
		public String x_typename;	//PdpSbuiBasicListItem
		public String title;	//2 guests
	}
	public class reviewData {
		public String x_typename;	//PdpOverviewV2ReviewData
		public String reviewCountText;	//70 reviews
		public String ratingText;	//4.84
		public String reviewCount;	//70
		public boolean isNewListing;
		public String ratingAccessibilityLabel;	//Rated 4.84 out of 5 stars.
		public loggingEventData loggingEventData;
	}
	public class aircover {
		public String x_typename;	//PlacementGroupsPerFormFactor
		public sections[] sections;
	}
	public class variables {
		public String id;	//U3RheUxpc3Rpbmc6NDcyMTM5MDQ=
		public pdpSectionsRequest pdpSectionsRequest;
	}
	public class pdpSectionsRequest {
		public String adults;	//1
		public amenityFilters amenityFilters;
		public boolean bypassTargetings;
		public String categoryTag;	//Tag:8188
		public causeId causeId;
		public String children;	//0
		public disasterId disasterId;
		public discountedGuestFeeVersion discountedGuestFeeVersion;
		public displayExtensions displayExtensions;
		public String federatedSearchId;	//95eb3912-c519-4692-9229-f02d5cdc974b
		public forceBoostPriorityMessageType forceBoostPriorityMessageType;
		public String infants;	//0
		public interactionType interactionType;
		// public layouts[] layouts;
		public Integer pets;	//0
		public pdpTypeOverride pdpTypeOverride;
		public String photoId;	//1651187599
		public boolean preview;
		public previousStateCheckIn previousStateCheckIn;
		public previousStateCheckOut previousStateCheckOut;
		public priceDropSource priceDropSource;
		public boolean privateBooking;
		public promotionUuid promotionUuid;
		public relaxedAmenityIds relaxedAmenityIds;
		public searchId searchId;
		public selectedCancellationPolicyId selectedCancellationPolicyId;
		public selectedRatePlanId selectedRatePlanId;
		public splitStays splitStays;
		public boolean staysBookingMigrationEnabled;
		public translateUgc translateUgc;
		public boolean useNewSectionWrapperApi;
		public sectionIds sectionIds;
		public String checkIn;	//2024-06-10
		public String checkOut;	//2024-06-15
		public String p3ImpressionId;	//p3_1717998010_P3DglOUmWbaaYpnD
	}
	public class amenityFilters {
	}
	public class causeId {
	}
	public class disasterId {
	}
	public class discountedGuestFeeVersion {
	}
	public class displayExtensions {
	}
	public class forceBoostPriorityMessageType {
	}
	public class interactionType {
	}
	// public class layouts {
	// 	public String 0;	//S
	// 	public String 1;	//I
	// 	public String 2;	//D
	// 	public String 3;	//E
	// 	public String 4;	//B
	// 	public String 5;	//A
	// 	public String 6;	//R
	// }
	public class pdpTypeOverride {
	}
	public class previousStateCheckIn {
	}
	public class previousStateCheckOut {
	}
	public class priceDropSource {
	}
	public class promotionUuid {
	}
	public class relaxedAmenityIds {
	}
	public class searchId {
	}
	public class selectedCancellationPolicyId {
	}
	public class selectedRatePlanId {
	}
	public class splitStays {
	}
	public class translateUgc {
	}
	public class sectionIds {
	}
	// public static AirbnbWrapper parse(String json){
    //     json = json.replace('__typename','x_typename');
	// 	return (AirbnbWrapper) System.JSON.deserialize(json, AirbnbWrapper.class);
	// }
}