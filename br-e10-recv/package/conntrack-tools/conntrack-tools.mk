#############################################################
#
# conntrack-tools
#
#############################################################

CONNTRACK_TOOLS_VERSION = 1.0.1
CONNTRACK_TOOLS_SOURCE = conntrack-tools-$(CONNTRACK_TOOLS_VERSION).tar.bz2
CONNTRACK_TOOLS_SITE = http://www.netfilter.org/projects/conntrack-tools/files
CONNTRACK_TOOLS_DEPENDENCIES = host-pkg-config libnetfilter_conntrack

$(eval $(call AUTOTARGETS))
