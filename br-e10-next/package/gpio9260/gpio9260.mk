#############################################################
#
# gpio9260
#
#############################################################
GPIO9260_VERSION = 1.0
GPIO9260_SOURCE = gpio9260-$(GPIO9260_VERSION).tar.gz
GPIO9260_SITE = https://www.jcwoltz.com/e10
GPIO9260_INSTALL_STAGING = YES
#GPIO9260_DEPENDENCIES = host-libaaa libbbb

define GPIO9260_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CC) LD=$(TARGET_LD) -C $(@D) all
endef

define GPIO9260_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/gpio9260 $(STAGING_DIR)/usr/bin
endef

define GPIO9260_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/gpio9260 $(TARGET_DIR)/usr/bin
endef

#$(eval $(call GENTARGETS,package,gpio9260))
$(eval $(gpio9260))
