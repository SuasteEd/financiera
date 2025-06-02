class ClientResponse {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? status;
  final String? rfc;
  final String? curp;
  final String? street;
  final String? colony;
  final String? state;
  final String? municipality;
  final String? nationality;
  final String? postalCode;
  final String? birthplace;
  final String? birthdate;
  final String? maritalStatus;
  final String? gender;
  final String? maritalRegime;
  final String? occupation;
  final String? spouseName;
  final String? spouseNationality;
  final String? spouseEmail;
  final String? pepPosition;
  final String? pepPeriod;
  final String? relatedPepName;
  final String? relatedPepPosition;
  final String? creditDestination;
  final String? resourceOrigin;
  final String? paymentFrequency;
  final int? paymentCount;
  final String? paymentType;
  final double? paymentAmount;
  final double? monthlyIncome;
  final double? otherIncome;
  final bool isPep;
  final bool relatedToPep;
  final bool actsOnOwnBehalf;
  final bool usesOwnResources;
  final Aval? aval;

  ClientResponse({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.status,
    this.rfc,
    this.curp,
    this.street,
    this.colony,
    this.state,
    this.municipality,
    this.nationality,
    this.postalCode,
    this.birthplace,
    this.birthdate,
    this.maritalStatus,
    this.gender,
    this.maritalRegime,
    this.occupation,
    this.spouseName,
    this.spouseNationality,
    this.spouseEmail,
    this.pepPosition,
    this.pepPeriod,
    this.relatedPepName,
    this.relatedPepPosition,
    this.creditDestination,
    this.resourceOrigin,
    this.paymentFrequency,
    this.paymentCount,
    this.paymentType,
    this.paymentAmount,
    this.monthlyIncome,
    this.otherIncome,
    this.isPep = false,
    this.relatedToPep = false,
    this.actsOnOwnBehalf = true,
    this.usesOwnResources = true,
    this.aval,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'status': status,
      'rfc': rfc,
      'curp': curp,
      'street': street,
      'colony': colony,
      'state': state,
      'municipality': municipality,
      'nationality': nationality,
      'postal_code': postalCode,
      'birthplace': birthplace,
      'birthdate': birthdate,
      'marital_status': maritalStatus,
      'gender': gender,
      'marital_regime': maritalRegime,
      'occupation': occupation,
      'spouse_name': spouseName,
      'spouse_nationality': spouseNationality,
      'spouse_email': spouseEmail,
      'pep_position': pepPosition,
      'pep_period': pepPeriod,
      'related_pep_name': relatedPepName,
      'related_pep_position': relatedPepPosition,
      'credit_destination': creditDestination,
      'resource_origin': resourceOrigin,
      'payment_frequency': paymentFrequency,
      'payment_count': paymentCount,
      'payment_type': paymentType,
      'payment_amount': paymentAmount,
      'monthly_income': monthlyIncome,
      'other_income': otherIncome,
      'is_pep': isPep ? 1 : 0,
      'related_to_pep': relatedToPep ? 1 : 0,
      'acts_on_own_behalf': actsOnOwnBehalf ? 1 : 0,
      'uses_own_resources': usesOwnResources ? 1 : 0,
      'aval': aval?.toJson(),
    };
  }

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      id: json['id'],
      name: json['name'] ?? '',
      phone: json['phone'],
      email: json['email'],
      status: json['status'],
      rfc: json['rfc'],
      curp: json['curp'],
      street: json['street'],
      colony: json['colony'],
      state: json['state'],
      municipality: json['municipality'],
      nationality: json['nationality'],
      postalCode: json['postal_code'],
      birthplace: json['birthplace'],
      birthdate: json['birthdate'],
      maritalStatus: json['marital_status'],
      gender: json['gender'],
      maritalRegime: json['marital_regime'],
      occupation: json['occupation'],
      spouseName: json['spouse_name'],
      spouseNationality: json['spouse_nationality'],
      spouseEmail: json['spouse_email'],
      pepPosition: json['pep_position'],
      pepPeriod: json['pep_period'],
      relatedPepName: json['related_pep_name'],
      relatedPepPosition: json['related_pep_position'],
      creditDestination: json['credit_destination'],
      resourceOrigin: json['resource_origin'],
      paymentFrequency: json['payment_frequency'],
      paymentCount: json['payment_count'],
      paymentType: json['payment_type'],
      paymentAmount: double.tryParse(json['payment_amount']?.toString() ?? ''),
      monthlyIncome: double.tryParse(json['monthly_income']?.toString() ?? ''),
      otherIncome: double.tryParse(json['other_income']?.toString() ?? ''),
      isPep: json['is_pep'] == 1,
      relatedToPep: json['related_to_pep'] == 1,
      actsOnOwnBehalf: json['acts_on_own_behalf'] == 1,
      usesOwnResources: json['uses_own_resources'] == 1,
      aval: json['aval'] != null ? Aval.fromJson(json['aval']) : null,
    );
  }
}

class Aval {
  final String name;
  final String? phone;
  final String? email;
  final String? rfc;
  final String? curp;
  final String? street;
  final String? colony;
  final String? state;
  final String? municipality;
  final String? nationality;
  final String? postalCode;
  final String? birthplace;
  final String? birthdate;
  final String? gender;
  final String? maritalStatus;
  final String? maritalRegime;
  final String? occupation;
  final String? spouseName;
  final String? spouseNationality;
  final String? spouseEmail;

  Aval({
    required this.name,
    this.phone,
    this.email,
    this.rfc,
    this.curp,
    this.street,
    this.colony,
    this.state,
    this.municipality,
    this.nationality,
    this.postalCode,
    this.birthplace,
    this.birthdate,
    this.gender,
    this.maritalStatus,
    this.maritalRegime,
    this.occupation,
    this.spouseName,
    this.spouseNationality,
    this.spouseEmail,
  });

  factory Aval.fromJson(Map<String, dynamic> json) {
    return Aval(
      name: json['name'] ?? '',
      phone: json['phone'],
      email: json['email'],
      rfc: json['rfc'],
      curp: json['curp'],
      street: json['street'],
      colony: json['colony'],
      state: json['state'],
      municipality: json['municipality'],
      nationality: json['nationality'],
      postalCode: json['postal_code'],
      birthplace: json['birthplace'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      maritalStatus: json['marital_status'],
      maritalRegime: json['marital_regime'],
      occupation: json['occupation'],
      spouseName: json['spouse_name'],
      spouseNationality: json['spouse_nationality'],
      spouseEmail: json['spouse_email'],
    );
  }

  //toJson method to convert Aval to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'rfc': rfc,
      'curp': curp,
      'street': street,
      'colony': colony,
      'state': state,
      'municipality': municipality,
      'nationality': nationality,
      'postal_code': postalCode,
      'birthplace': birthplace,
      'birthdate': birthdate,
      'gender': gender,
      'marital_status': maritalStatus,
      'marital_regime': maritalRegime,
      'occupation': occupation,
      'spouse_name': spouseName,
      'spouse_nationality': spouseNationality,
      'spouse_email': spouseEmail,
    };
  }
}
