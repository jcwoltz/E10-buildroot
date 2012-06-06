#############################################################
#
# usb_modeswitch_data
# http://www.draisberghof.de/usb_modeswitch/usb-modeswitch-data-20120531.tar.bz2
#############################################################

USB_MODESWITCH_DATA_VERSION = 20120531
USB_MODESWITCH_DATA_SOURCE = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VERSION).tar.bz2
USB_MODESWITCH_DATA_SITE = http://www.draisberghof.de/usb_modeswitch
USB_MODESWITCH_DATA_DEPENDENCIES = usb_modeswitch

define USB_MODESWITCH_DATA_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define USB_MODESWITCH_DATA_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef


define USB_MODESWITCH_DATA_CLEAN_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) clean
endef

$(eval $(call GENTARGETS))

