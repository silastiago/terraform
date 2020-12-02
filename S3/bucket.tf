resource "aws_s3_bucket" "bucket" { 
   bucket = "bucketsilas"
   acl = "private"

   versioning { 
      enabled = true
   } 
   tags = { 
     Name = "bucketsilas" 
     Environment = "bucketsilas" 
   } 
}