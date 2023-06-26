public class displayTableController {
    // Method to retrieve a list of Wrapper objects in LWC component
    @AuraEnabled(Cacheable=true)
    public static List<Wrapper> getWrapper(){
        List<Wrapper> wrapperList = new List<Wrapper>();
        
        // Querying a list of Account and Product2 records
        List<Account> aList = [SELECT Id, Name FROM Account LIMIT 10];
        List<Product2> pList = [SELECT Id, Name FROM Product2 LIMIT 10];
        
        // Determining the maximum count between the two lists
        Integer maxCount = Math.max(aList.size(), pList.size());
        
        // Looping through the maximum count
        for(Integer i = 0; i < maxCount; i++){
            // Assigning Account and Product2 objects based on index
            Account a = (i < aList.size()) ? aList[i] : null;
            Product2 p = (i < pList.size()) ? pList[i] : null;
            
            // Creating a new Wrapper object and adding it to the list
            Wrapper w = new Wrapper(a, p);
            wrapperList.add(w);
        }
        
        // Returning the list of Wrapper objects
        return wrapperList;
    }
    
    // Wrapper class to combine Account and Product2 information
    public class Wrapper{
        @AuraEnabled public Account a;
        @AuraEnabled public String prodname;
        
        // Constructor to initialize the Wrapper object
        public Wrapper(Account a, Product2 p){
            this.a = a;
            this.prodname = (p.Id != null) ? p.Name : '';
        }
    }
}