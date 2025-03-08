import 'package:b2b_partenership/core/constants/app_constants.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:equatable/equatable.dart';

class ClientJobApplicationModel extends Equatable {
  final String jobApplicationId;
  final String clientId;
  final String yearsOfExperience;
  final String coverLetter;
  final String resume;
  final String skills;
  final String availableToStartDate;
  final String expectedSalary;
  final String whyIdealCandidate;
  final String applicationStatus;
  final String jobId;
  final String jobTitle;
  final String jobDescription;
  final String jobSkills;
  final JobsContractTypeEnum jobContractType;
  final String jobExpirationDate;
  final String jobGender;
  final String jobSalary;
  final String jobStatus;
  final String userId;
  final String providerName;
  final String providerEmail;
  final String providerCountryCode;
  final String providerPhone;
  final String providerImage;
  final String providerRating;
  final String createdAt;
  final String updatedAt;

  const ClientJobApplicationModel({
    required this.jobApplicationId,
    required this.clientId,
    required this.yearsOfExperience,
    required this.coverLetter,
    required this.resume,
    required this.skills,
    required this.availableToStartDate,
    required this.expectedSalary,
    required this.whyIdealCandidate,
    required this.applicationStatus,
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobSkills,
    required this.jobContractType,
    required this.jobExpirationDate,
    required this.jobGender,
    required this.jobSalary,
    required this.jobStatus,
    required this.userId,
    required this.providerName,
    required this.providerEmail,
    required this.providerCountryCode,
    required this.providerPhone,
    required this.providerImage,
    required this.providerRating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientJobApplicationModel.fromJson(Map<String, dynamic> json) =>
      ClientJobApplicationModel(
        jobApplicationId: json["job_application_id"].toString(),
        clientId: json["client_id"].toString(),
        yearsOfExperience: json["years_of_experience"].toString(),
        coverLetter: json["cover_letter"].toString(),
        resume: kBaseImageUrl + json["resume"].toString(),
        skills: json["skills"].toString(),
        availableToStartDate: json["available_to_start_date"].toString(),
        expectedSalary: json["expected_salary"].toString(),
        whyIdealCandidate: json["why_ideal_candidate"].toString(),
        applicationStatus: json["application_status"].toString(),
        jobId: json["job_id"].toString(),
        jobTitle: json["job_title"].toString(),
        jobDescription: json["job_description"].toString(),
        jobSkills: json["job_skills"].toString(),
        jobContractType: json["job_contract_type"] != null
            ? JobsContractTypeEnum.values.firstWhere(
                (element) => element.value == json["job_contract_type"],
              )
            : JobsContractTypeEnum.fullTime,
        jobExpirationDate: json["job_expiration_date"].toString(),
        jobGender: json["job_gender"].toString(),
        jobSalary: json["job_salary"].toString(),
        jobStatus: json["job_status"].toString(),
        userId: json["user_id"].toString(),
        providerName: json["provider_name"].toString(),
        providerEmail: json["provider_email"].toString(),
        providerCountryCode: json["provider_country_code"].toString(),
        providerPhone: json["provider_phone"].toString(),
        providerImage: kBaseImageUrl + json["provider_image"].toString(),
        providerRating: json["provider_rating"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );
  @override
  List<Object?> get props => [
        jobApplicationId,
        clientId,
        yearsOfExperience,
        coverLetter,
        resume,
        skills,
        availableToStartDate,
        expectedSalary,
        whyIdealCandidate,
        applicationStatus,
        jobId,
        jobTitle,
        jobDescription,
        jobSkills,
        jobContractType,
        jobExpirationDate,
        jobGender,
        jobSalary,
        jobStatus,
        userId,
        providerName,
        providerEmail,
        providerCountryCode,
        providerPhone,
        providerImage,
        providerRating,
        createdAt,
        updatedAt,
      ];
}
