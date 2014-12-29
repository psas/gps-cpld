

## Xilinx(TM) provides some software to create designs for CPLDs and FPGAs. It is called "ISE Webpack"

### ISE Software Notes

* Go to the Xilinx web site
  * Get an account

* Download page
  * http://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/design-tools.html

* Get these files
  * Xilinx_ISE_DS_14.7_1015_1-2.zip.xz
  * Xilinx_ISE_DS_14.7_1015_1-1.tar
  * Xilinx_ISE_DS_14.7_1015_1-4.zip.xz
  * Xilinx_ISE_DS_14.7_1015_1-3.zip.xz

* create a directory called Xilinx-install (or similar)
* place all four files inside of this new directory

``` 
cd Xilinx-install
tar zxf Xilinx_ISE_DS_14.7_1015_1-1.tar
cd bin/lin64
./xsetup
```
* The install is about 25Gb. Yep, you read that right.

### Licence Notes

* Go to the Xilinx web site
  * Log in with your account
  * Home:Support:Product Licensing
    * Wanted:  ISE WebPACK Licence
  * Eventually the process ends with a license file delivered by email.

* On Linux-based systems install license to ~/.Xilinx
  * File is called "Xilinx.lic"

### Executing ISE Notes

* Assuming that install was to /opt/Xilinx:

```
#!/bin/bash

# Start Xilinx ISE Webpack
/opt/Xilinx/14.7/ISE_DS/settings64.sh
/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise
```

