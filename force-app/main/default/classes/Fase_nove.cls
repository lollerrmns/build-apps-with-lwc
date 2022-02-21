public with sharing class Fase_nove {
    @AuraEnabled(cacheable = true)
    public static String getProjectId(String idd){
        return idd;
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> listaContasAtivas(String idd){
        try {
            String idRecordType = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Colaborador').getRecordTypeId();
            List<Account> a = DAO_Fase_Nove.getAccountByRecordType(idRecordType);
            System.debug('Lista Contas Ativas'+idd);
            System.debug(a);
            return a;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> listaContasDoProjeto(String idd){
        try {
            List<Projeto_Colaborador__c> colab = DAO_Fase_Nove.getColaboradorFromProjeto(idd);
            List<String>  colaboradores = new List<String>();
            for (Projeto_Colaborador__c cc : colab) {
                colaboradores.add(cc.Colaborador__c+'');
            }
            List<Account> a = DAO_Fase_Nove.getAccountByIds(colaboradores);
            System.debug('Lista contas do Projeto'+idd);
            System.debug(a);
            return a;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void gravar(List<String> idds,String proj){
        System.debug('WRITE');
        System.debug('IDDS = '+idds);
        System.debug('proj = '+proj);
        List<Projeto_Colaborador__c> c = DAO_Fase_Nove.getColaboradorFromProjeto(proj);
        System.debug('colab = '+c);
        //List<Account> atual = listaContasDoProjeto(String proj);
        //List<Account> atualiza = new List<Account>();
        //List<Account> remover = new List<Account>();
        delete c;
        List<Projeto_Colaborador__c> novo = new List<Projeto_Colaborador__c>();
        for (String colab : idds) {
            novo.add(new Projeto_Colaborador__c(Colaborador__c = colab,Projeto__c = proj));
        }
        System.debug('novo = '+novo);
        insert novo;
    }
}