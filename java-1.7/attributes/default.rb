	default['java-1.7']['dir'] = "/opt/jdk1.7.0_79/"
	


	case node['kernel']['machine'] 

	 when 'x86_64'
	  default['java-1.7']['url'] = "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz"
	  default['java-1.7']['arch'] = "jdk-7u79-linux-x64.tar.gz"
	 when 'i586'
	  default['java-1.7']['url'] = "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-i586.tar.gz"
	  default['java-1.7']['arch'] = "jdk-7u79-linux-i586.tar.gz"
	
	 end
