class_name UpgradeItemEntry
extends PanelContainer

signal pressed


func init(weapon: Weapon) -> void:
	var upgrade: WeaponUpgrade = weapon.get_next_upgrade()
	%Name.text = "[b]%s[/b]" % weapon.item_name
	%FlavorText.text = "[i]%s[/i]" % weapon.flavor_text
	%UpgradeText.text = upgrade.description
	%WeaponIcon.texture = weapon.icon
	pressed.connect(weapon.level_up)


func _on_button_pressed() -> void:
	pressed.emit()


func _on_focus_entered() -> void:
	%Button.grab_focus()
