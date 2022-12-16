No way to go direct from packer to nutanix 

convert the master blueprint and use ansible to run through all the tasks
- rsg_adc_prod_master_server2019

using packer, rundeck(ansible), choco, 

packer template
- gets push to the t2 vcenter content library 
- ? no way to import into nutanix
	- nfs share is the current work around 
- prism
	- nutanix prism element 
	- settings > image configuration > upload image
	- go to prism central 
		- import images from cluster 
- calm
	- find the blueprint
	- rsg_adc_prod_import_windowsServer2019
	- pull in the vm specs and run a playbook 


? how to install nutanix tools 


