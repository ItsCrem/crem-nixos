{
lib,
pkgs,
config,
...
}:{
	options = {
		internal.enable =
			lib.mkEnableOption "enables internal";
	};

	config = lib.mkIf config.internal.enable {
	# All packages used for internal assessments
		home.packages = with pkgs; [
			python311Packages.impacket
            python311Packages.lsassy
            python311Packages.pypykatz
            mitm6
            certipy
            responder
            evil-winrm
            smbmap
            samba
            kerbrute
            coercer
            cewl
            postgresql_16
            unstable.autobloody
            unstable.netexec
            unstable.adidnsdump

           # (callPackage ../../pkgs/cewler/package.nix {})

            # LDAP #
            python311Packages.msldap
            adenum
            bloodhound-py
            msldapdump
            ldapmonitor
            ldapdomaindump
            ldapnomnom
            ldeep
            silenthound
        ];
	};
}
