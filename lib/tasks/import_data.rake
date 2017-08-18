require 'csv'

namespace :import do
  task :all => [:cleanout, :import_customers, :import_merchants, :import_items, :import_invoices, :import_invoice_items, :import_transactions]

  task :cleanout do
    Rails.env = "development"
    Rake::Task["db:reset"].invoke
    Rails.env = "test"
    Rake::Task["db:reset"].invoke
  end

  task :import_customers => [:environment] do
    file = File.read('./db/data/customers.csv')
    csv = CSV.parse(file, :headers => true)
    csv.each do |row|
      customer = Customer.create!(row.to_hash)
      puts "created customer #{customer.id}"
    end
  end

  task :import_merchants => [:environment] do
    file = File.read('./db/data/merchants.csv')
    csv = CSV.parse(file, :headers => true)
    csv.each do |row|
      merchant = Merchant.create!(row.to_hash)
      puts "created merchant #{merchant.id}"
    end
  end

  task :import_items => [:environment] do
    file = File.read('./db/data/items.csv')
    csv = CSV.parse(file, :headers => true)
    csv.each do |row|
      item = Item.create!(
        name: row["name"],
        description: row["description"],
        unit_price: row["unit_price"].to_f/100,
        merchant_id: row["merchant_id"],
        created_at: row["created_at"],
        updated_at: row["updated_at"])
      puts "created item #{item.id}"
    end
  end

  task :import_invoices => [:environment] do
    file = File.read('./db/data/invoices.csv')
    csv = CSV.parse(file, :headers => true)
    csv.each do |row|
      invoice = Invoice.create!(row.to_hash)
      puts "created invoice #{invoice.id}"
    end
  end

  task :import_invoice_items => [:environment] do
    file = File.read('./db/data/invoice_items.csv')
    csv = CSV.parse(file, :headers => true)
    csv.each do |row|
      invoice_item = InvoiceItem.create!(
        item_id: row["item_id"],
        invoice_id: row["invoice_id"],
        quantity: row["quantity"],
        unit_price: row["unit_price"].to_f/100,
        created_at: row["created_at"],
        updated_at: row["updated_at"])
      puts "created invoice_item #{invoice_item.id}"
    end
  end

  task :import_transactions => [:environment] do
    file = File.read('./db/data/transactions.csv')
    csv = CSV.parse(file, :headers => true, :header_converters => :symbol)
    csv.each do |row|
      transaction = Transaction.create!(
        credit_card_number: row[:credit_card_number],
        result: row[:result],
        invoice_id: row[:invoice_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
      puts "created transaction #{transaction.id}"
    end
  end
end
