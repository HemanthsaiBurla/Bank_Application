package Bank_Application;

import java.sql.Timestamp;

public class Transaction {
    private String senderAccno;
    private String receiverAccno;
    private double amount;
    private String transactionType;
    private Timestamp transactionDate;  // ✅ Changed from Date to Timestamp
    private String transactionStatus;

    // Constructor
    public Transaction(String senderAccno, String receiverAccno, double amount, String transactionType, Timestamp transactionDate, String transactionStatus) {
        this.senderAccno = senderAccno;
        this.receiverAccno = receiverAccno;
        this.amount = amount;
        this.transactionType = transactionType;
        this.transactionDate = transactionDate;
        this.transactionStatus = transactionStatus;
    }

    // getters and Setters
    public String getSenderAccno() { return senderAccno; }
    public void setSenderAccno(String senderAccno) { this.senderAccno = senderAccno; }

    public String getReceiverAccno() { return receiverAccno; }
    public void setReceiverAccno(String receiverAccno) { this.receiverAccno = receiverAccno; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }

    public Timestamp getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Timestamp transactionDate) { this.transactionDate = transactionDate; }

    public String getTransactionStatus() { return transactionStatus; }
    public void setTransactionStatus(String transactionStatus) { this.transactionStatus = transactionStatus; }

    // toString Method
    @Override
    public String toString() {
        return "Transaction [senderAccno=" + senderAccno + ", receiverAccno=" + receiverAccno + ", amount=" + amount
                + ", transactionType=" + transactionType + ", transactionDate=" + transactionDate 
                + ", transactionStatus=" + transactionStatus + "]";
    }
}
