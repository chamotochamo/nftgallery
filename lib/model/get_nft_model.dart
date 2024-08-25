class NFT {
  final String identifier;
  final String collection;
  final String contract;
  final String tokenStandard;
  final String name;
  final String description;
  final String imageUrl;
  final String metadataUrl;
  final String openseaUrl;
  final String updatedAt;
  final bool isDisabled;
  final bool isNSFW;

  NFT({
    required this.identifier,
    required this.collection,
    required this.contract,
    required this.tokenStandard,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.metadataUrl,
    required this.openseaUrl,
    required this.updatedAt,
    required this.isDisabled,
    required this.isNSFW,
  });

  factory NFT.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image_url'] ?? '';

    // Replace "https://ipfs.io/" with "https://gateway.pinata.cloud/"
    //imageUrl = imageUrl.replaceFirst("https://ipfs.io/", "https://gateway.pinata.cloud/");

    return NFT(
      identifier: json['identifier'] ?? '',
      collection: json['collection'] ?? '',
      contract: json['contract'] ?? '',
      tokenStandard: json['token_standard'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: imageUrl,
      metadataUrl: json['metadata_url'] ?? '',
      openseaUrl: json['opensea_url'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isDisabled: json['is_disabled'] ?? false,
      isNSFW: json['is_nsfw'] ?? false,
    );
  }
}
