import '../Meta/CostModel.dart';
import '../Meta/DamageModel.dart';

class WeaponEquipment {
  String? index;
  String? name;
  List<String>? desc;
  String? equipmentCategory;
  String? weaponCategory;
  String? weaponRange;
  String? categoryRange;
  int? rangeNormal;
  int? rangeLong;
  Damage? damage;
  Damage? twoHandedDamage;
  List<String>? properties;
  Cost? cost;
  int? weight;

  WeaponEquipment({
    this.index,
    this.name,
    this.desc,
    this.equipmentCategory,
    this.weaponCategory,
    this.weaponRange,
    this.categoryRange,
    this.rangeNormal,
    this.rangeLong,
    this.damage,
    this.twoHandedDamage,
    this.properties,
    this.cost,
    this.weight
  });

  factory WeaponEquipment.fromMap(Map<String, dynamic> map) {
    var propertiesList = map['properties'] as List;
    return WeaponEquipment(
      index: map['index'],
      name: map['name'],
      desc: map['desc'],
      equipmentCategory: map['equipment_category']['name'],
      weaponCategory: map['weapon_category'],
      weaponRange: map['weapon_range'],
      categoryRange: map['category_range'],
      rangeNormal: map['range']['normal'],
      rangeLong: map['range']['long'],
      damage: Damage.fromMap(map['damage']),
      twoHandedDamage: Damage.fromMap(map['two_handed_damage']),
      properties: propertiesList.map((property) => property['name'] as String).toList(),
      cost: Cost.fromMap(map['cost']),
      weight: map['weight']
    );
  }
}