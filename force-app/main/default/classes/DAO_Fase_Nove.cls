public with sharing class DAO_Fase_Nove {

    public static List<Account> getAccountByRecordType(String idRecordType){
        return [SELECT Id,Name FROM Account WHERE Ativo__c = true AND RecordTypeId = :idRecordType];
    }
    public static List<Account> getAccountByIds(List<String> ids){
        return [SELECT Id,Name FROM Account WHERE Id = :ids];
    }
    public static List<Projeto_Colaborador__c> getColaboradorFromProjeto(String projeto){
        return [SELECT Id,Name,Colaborador__c FROM Projeto_Colaborador__c WHERE Projeto__c = :projeto];
    }

}