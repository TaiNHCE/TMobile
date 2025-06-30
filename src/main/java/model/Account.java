package model;

import java.util.Date;

public class Account {
    private int accountID;
    private String email;
    private String passwordHash;
    private Date createdAt;
    private boolean isActive;
    private int roleID;
    private boolean emailVerified;
    private String profileImageURL;

    public Account() {}

    public Account(int accountID, String email, String passwordHash, Date createdAt, 
                   boolean isActive, int roleID, boolean emailVerified, String profileImageURL) {
        this.accountID = accountID;
        this.email = email;
        this.passwordHash = passwordHash;
        this.createdAt = createdAt;
        this.isActive = isActive;
        this.roleID = roleID;
        this.emailVerified = emailVerified;
        this.profileImageURL = profileImageURL;
    }

    // Getters and Setters
    public int getAccountID() { return accountID; }
    public void setAccountID(int accountID) { this.accountID = accountID; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public boolean isIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public int getRoleID() { return roleID; }
    public void setRoleID(int roleID) { this.roleID = roleID; }
    public boolean isEmailVerified() { return emailVerified; }
    public void setEmailVerified(boolean emailVerified) { this.emailVerified = emailVerified; }
    public String getProfileImageURL() { return profileImageURL; }
    public void setProfileImageURL(String profileImageURL) { this.profileImageURL = profileImageURL; }
}