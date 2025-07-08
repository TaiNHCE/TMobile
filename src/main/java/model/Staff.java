/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


/**
 *
 * @author pc
 */
public class Staff {
    private int staffID;
    private String email;
    private String fullName;
    private String phone;
    private String hiredDate;
    private String birthDay;
    private String gender;
    private String position;

    public Staff() {
    }

    public Staff(int staffID, String email, String fullName, String hiredDate) {
        this.staffID = staffID;
        this.email = email;
        this.fullName = fullName;
        this.hiredDate = hiredDate;
    }

    public Staff(int staffID, String email, String fullName, String phone, String hiredDate,String position, String birthDay, String gender) {
        this.staffID = staffID;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.hiredDate = hiredDate;
        this.position = position;
        this.birthDay = birthDay;
        this.gender = gender;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getHiredDate() {
        return hiredDate;
    }

    public void setHiredDate(String hiredDate) {
        this.hiredDate = hiredDate;
    }

    public String getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(String birthDay) {
        this.birthDay = birthDay;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
    
}
