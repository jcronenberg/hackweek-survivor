class_name UpgradeItemEntry
extends PanelContainer

signal pressed


func init(upgrade) -> void:
	%Name.text = "[b]%s[/b]" % upgrade.item_name
	%FlavorText.text = "[i]%s[/i]" % upgrade.flavor_text
	%WeaponIcon.texture = upgrade.icon
	if upgrade is Weapon:
		%UpgradeText.text = upgrade.get_next_upgrade().description

	pressed.connect(upgrade.level_up)


func _on_button_pressed() -> void:
	pressed.emit()


func _on_focus_entered() -> void:
	%Button.grab_focus()
