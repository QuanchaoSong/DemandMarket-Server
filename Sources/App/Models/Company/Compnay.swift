//
//  File.swift
//  
//
//  Created by Albus on 5/5/20.
//

import Vapor
import Fluent


final class Company: Model, Content {
    static let schema = "companies"
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    @Field(key: "name")
    var name: String?
    
    @Field(key: "owner_name")
    var owner_name: String?
    
    @Field(key: "registration_code")
    var registration_code: String?
    
    @Field(key: "serial_number")
    var serial_number: String?
    
    @Field(key: "reg_capital")
    var reg_capital: String?
    
    @Field(key: "paidin_capital")
    var paidin_capital: String?
    
    @Field(key: "scope")
    var scope: String?
    
    @Field(key: "register_date")
    var register_date: String?
    
    @Field(key: "expiring_date")
    var expiring_date: String?
    
    @Field(key: "company_province")
    var company_province: String?
    
    @Field(key: "company_city")
    var company_city: String?
    
    @Field(key: "company_district")
    var company_district: String?
    
    @Field(key: "detail_address")
    var detail_address: String?
    
    @Field(key: "contact_person")
    var contact_person: String?
    
    @Field(key: "contact_phone")
    var contact_phone: String?
    
    @Field(key: "contact_email")
    var contact_email: String?
    
    @Field(key: "business_license_url")
    var business_license_url: String?
    
    @Field(key: "status")
    var status: Int?
    
    @Field(key: "speciality_id")
    var speciality_id: Int?
    
    @Field(key: "create_time")
    var create_time: Date?
    
    @Field(key: "creator_id")
    var creator_id: String?
    
    
    func importData(from params: CompanyCreationRequest) -> Void {
        self.name = params.name
        self.owner_name = params.owner_name
        self.registration_code = params.registration_code
        self.serial_number = params.serial_number
        self.reg_capital = params.reg_capital
        self.paidin_capital = params.paidin_capital
        self.scope = params.scope
        self.register_date = params.register_date
        self.expiring_date = params.expiring_date
        self.speciality_id = params.speciality_id
        self.company_province = params.company_province ?? ""
        self.company_city = params.company_city ?? ""
        self.company_district = params.company_district ?? ""
        self.detail_address = params.detail_address
        self.contact_phone = params.contact_phone
        self.contact_email = params.contact_email
        self.business_license_url = params.business_license_url
    }
}


struct CompanyCreationRequest : Content {
    var name: String?
    var owner_name: String?
    var registration_code: String?
    var serial_number: String?
    var reg_capital: String?
    var paidin_capital: String?
    var scope: String?
    var register_date: String?
    var expiring_date: String?
    var speciality_id: Int?
    var company_province: String?
    var company_city: String?
    var company_district: String?
    var detail_address: String?
    var contact_person: String?
    var contact_phone: String?
    var contact_email: String?
    var business_license_url: String?
}
