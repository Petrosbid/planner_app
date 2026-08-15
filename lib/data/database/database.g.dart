// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Julian'));
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _energyPreferenceMeta =
      const VerificationMeta('energyPreference');
  @override
  late final GeneratedColumn<String> energyPreference = GeneratedColumn<String>(
      'energy_preference', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('morning'));
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('fa'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, avatarUrl, energyPreference, locale, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('energy_preference')) {
      context.handle(
          _energyPreferenceMeta,
          energyPreference.isAcceptableOrUnknown(
              data['energy_preference']!, _energyPreferenceMeta));
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      energyPreference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}energy_preference'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String name;
  final String? avatarUrl;
  final String energyPreference;
  final String locale;
  final DateTime createdAt;
  const UserProfile(
      {required this.id,
      required this.name,
      this.avatarUrl,
      required this.energyPreference,
      required this.locale,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['energy_preference'] = Variable<String>(energyPreference);
    map['locale'] = Variable<String>(locale);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      energyPreference: Value(energyPreference),
      locale: Value(locale),
      createdAt: Value(createdAt),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      energyPreference: serializer.fromJson<String>(json['energyPreference']),
      locale: serializer.fromJson<String>(json['locale']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'energyPreference': serializer.toJson<String>(energyPreference),
      'locale': serializer.toJson<String>(locale),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserProfile copyWith(
          {String? id,
          String? name,
          Value<String?> avatarUrl = const Value.absent(),
          String? energyPreference,
          String? locale,
          DateTime? createdAt}) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        energyPreference: energyPreference ?? this.energyPreference,
        locale: locale ?? this.locale,
        createdAt: createdAt ?? this.createdAt,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      energyPreference: data.energyPreference.present
          ? data.energyPreference.value
          : this.energyPreference,
      locale: data.locale.present ? data.locale.value : this.locale,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('energyPreference: $energyPreference, ')
          ..write('locale: $locale, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, avatarUrl, energyPreference, locale, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatarUrl == this.avatarUrl &&
          other.energyPreference == this.energyPreference &&
          other.locale == this.locale &&
          other.createdAt == this.createdAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> avatarUrl;
  final Value<String> energyPreference;
  final Value<String> locale;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.energyPreference = const Value.absent(),
    this.locale = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.energyPreference = const Value.absent(),
    this.locale = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? avatarUrl,
    Expression<String>? energyPreference,
    Expression<String>? locale,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (energyPreference != null) 'energy_preference': energyPreference,
      if (locale != null) 'locale': locale,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? avatarUrl,
      Value<String>? energyPreference,
      Value<String>? locale,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      energyPreference: energyPreference ?? this.energyPreference,
      locale: locale ?? this.locale,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (energyPreference.present) {
      map['energy_preference'] = Variable<String>(energyPreference.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('energyPreference: $energyPreference, ')
          ..write('locale: $locale, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LifeAreasTable extends LifeAreas
    with TableInfo<$LifeAreasTable, LifeArea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LifeAreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('spa'));
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#3C51C2'));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, icon, colorHex, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'life_areas';
  @override
  VerificationContext validateIntegrity(Insertable<LifeArea> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LifeArea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LifeArea(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $LifeAreasTable createAlias(String alias) {
    return $LifeAreasTable(attachedDatabase, alias);
  }
}

class LifeArea extends DataClass implements Insertable<LifeArea> {
  final String id;
  final String name;
  final String? description;
  final String icon;
  final String colorHex;
  final int orderIndex;
  const LifeArea(
      {required this.id,
      required this.name,
      this.description,
      required this.icon,
      required this.colorHex,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['icon'] = Variable<String>(icon);
    map['color_hex'] = Variable<String>(colorHex);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  LifeAreasCompanion toCompanion(bool nullToAbsent) {
    return LifeAreasCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: Value(icon),
      colorHex: Value(colorHex),
      orderIndex: Value(orderIndex),
    );
  }

  factory LifeArea.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LifeArea(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<String>(icon),
      'colorHex': serializer.toJson<String>(colorHex),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  LifeArea copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? icon,
          String? colorHex,
          int? orderIndex}) =>
      LifeArea(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        icon: icon ?? this.icon,
        colorHex: colorHex ?? this.colorHex,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  LifeArea copyWithCompanion(LifeAreasCompanion data) {
    return LifeArea(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LifeArea(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('colorHex: $colorHex, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, icon, colorHex, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LifeArea &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.colorHex == this.colorHex &&
          other.orderIndex == this.orderIndex);
}

class LifeAreasCompanion extends UpdateCompanion<LifeArea> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> icon;
  final Value<String> colorHex;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const LifeAreasCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LifeAreasCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<LifeArea> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? colorHex,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (colorHex != null) 'color_hex': colorHex,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LifeAreasCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? icon,
      Value<String>? colorHex,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return LifeAreasCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LifeAreasCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('colorHex: $colorHex, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lifeAreaIdMeta =
      const VerificationMeta('lifeAreaId');
  @override
  late final GeneratedColumn<String> lifeAreaId = GeneratedColumn<String>(
      'life_area_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _visionTextMeta =
      const VerificationMeta('visionText');
  @override
  late final GeneratedColumn<String> visionText = GeneratedColumn<String>(
      'vision_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        lifeAreaId,
        visionText,
        targetDate,
        isCompleted,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('life_area_id')) {
      context.handle(
          _lifeAreaIdMeta,
          lifeAreaId.isAcceptableOrUnknown(
              data['life_area_id']!, _lifeAreaIdMeta));
    }
    if (data.containsKey('vision_text')) {
      context.handle(
          _visionTextMeta,
          visionText.isAcceptableOrUnknown(
              data['vision_text']!, _visionTextMeta));
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      lifeAreaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}life_area_id']),
      visionText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vision_text']),
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String title;
  final String? description;
  final String? lifeAreaId;
  final String? visionText;
  final DateTime? targetDate;
  final bool isCompleted;
  final DateTime createdAt;
  const Goal(
      {required this.id,
      required this.title,
      this.description,
      this.lifeAreaId,
      this.visionText,
      this.targetDate,
      required this.isCompleted,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lifeAreaId != null) {
      map['life_area_id'] = Variable<String>(lifeAreaId);
    }
    if (!nullToAbsent || visionText != null) {
      map['vision_text'] = Variable<String>(visionText);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lifeAreaId: lifeAreaId == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeAreaId),
      visionText: visionText == null && nullToAbsent
          ? const Value.absent()
          : Value(visionText),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      lifeAreaId: serializer.fromJson<String?>(json['lifeAreaId']),
      visionText: serializer.fromJson<String?>(json['visionText']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'lifeAreaId': serializer.toJson<String?>(lifeAreaId),
      'visionText': serializer.toJson<String?>(visionText),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Goal copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> lifeAreaId = const Value.absent(),
          Value<String?> visionText = const Value.absent(),
          Value<DateTime?> targetDate = const Value.absent(),
          bool? isCompleted,
          DateTime? createdAt}) =>
      Goal(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        lifeAreaId: lifeAreaId.present ? lifeAreaId.value : this.lifeAreaId,
        visionText: visionText.present ? visionText.value : this.visionText,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      lifeAreaId:
          data.lifeAreaId.present ? data.lifeAreaId.value : this.lifeAreaId,
      visionText:
          data.visionText.present ? data.visionText.value : this.visionText,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('visionText: $visionText, ')
          ..write('targetDate: $targetDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, lifeAreaId,
      visionText, targetDate, isCompleted, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.lifeAreaId == this.lifeAreaId &&
          other.visionText == this.visionText &&
          other.targetDate == this.targetDate &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> lifeAreaId;
  final Value<String?> visionText;
  final Value<DateTime?> targetDate;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.visionText = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.visionText = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? lifeAreaId,
    Expression<String>? visionText,
    Expression<DateTime>? targetDate,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (lifeAreaId != null) 'life_area_id': lifeAreaId,
      if (visionText != null) 'vision_text': visionText,
      if (targetDate != null) 'target_date': targetDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? lifeAreaId,
      Value<String?>? visionText,
      Value<DateTime?>? targetDate,
      Value<bool>? isCompleted,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lifeAreaId: lifeAreaId ?? this.lifeAreaId,
      visionText: visionText ?? this.visionText,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lifeAreaId.present) {
      map['life_area_id'] = Variable<String>(lifeAreaId.value);
    }
    if (visionText.present) {
      map['vision_text'] = Variable<String>(visionText.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('visionText: $visionText, ')
          ..write('targetDate: $targetDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MilestonesTable extends Milestones
    with TableInfo<$MilestonesTable, Milestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, goalId, title, targetDate, isCompleted, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'milestones';
  @override
  VerificationContext validateIntegrity(Insertable<Milestone> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Milestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Milestone(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $MilestonesTable createAlias(String alias) {
    return $MilestonesTable(attachedDatabase, alias);
  }
}

class Milestone extends DataClass implements Insertable<Milestone> {
  final String id;
  final String goalId;
  final String title;
  final DateTime? targetDate;
  final bool isCompleted;
  final int orderIndex;
  const Milestone(
      {required this.id,
      required this.goalId,
      required this.title,
      this.targetDate,
      required this.isCompleted,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  MilestonesCompanion toCompanion(bool nullToAbsent) {
    return MilestonesCompanion(
      id: Value(id),
      goalId: Value(goalId),
      title: Value(title),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      isCompleted: Value(isCompleted),
      orderIndex: Value(orderIndex),
    );
  }

  factory Milestone.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Milestone(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      title: serializer.fromJson<String>(json['title']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'title': serializer.toJson<String>(title),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  Milestone copyWith(
          {String? id,
          String? goalId,
          String? title,
          Value<DateTime?> targetDate = const Value.absent(),
          bool? isCompleted,
          int? orderIndex}) =>
      Milestone(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        title: title ?? this.title,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        isCompleted: isCompleted ?? this.isCompleted,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  Milestone copyWithCompanion(MilestonesCompanion data) {
    return Milestone(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      title: data.title.present ? data.title.value : this.title,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Milestone(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('targetDate: $targetDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, goalId, title, targetDate, isCompleted, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Milestone &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.title == this.title &&
          other.targetDate == this.targetDate &&
          other.isCompleted == this.isCompleted &&
          other.orderIndex == this.orderIndex);
}

class MilestonesCompanion extends UpdateCompanion<Milestone> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<String> title;
  final Value<DateTime?> targetDate;
  final Value<bool> isCompleted;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const MilestonesCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.title = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MilestonesCompanion.insert({
    required String id,
    required String goalId,
    required String title,
    this.targetDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        goalId = Value(goalId),
        title = Value(title);
  static Insertable<Milestone> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<String>? title,
    Expression<DateTime>? targetDate,
    Expression<bool>? isCompleted,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (title != null) 'title': title,
      if (targetDate != null) 'target_date': targetDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MilestonesCompanion copyWith(
      {Value<String>? id,
      Value<String>? goalId,
      Value<String>? title,
      Value<DateTime?>? targetDate,
      Value<bool>? isCompleted,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return MilestonesCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MilestonesCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('targetDate: $targetDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lifeAreaIdMeta =
      const VerificationMeta('lifeAreaId');
  @override
  late final GeneratedColumn<String> lifeAreaId = GeneratedColumn<String>(
      'life_area_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        goalId,
        lifeAreaId,
        deadline,
        progress,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('life_area_id')) {
      context.handle(
          _lifeAreaIdMeta,
          lifeAreaId.isAcceptableOrUnknown(
              data['life_area_id']!, _lifeAreaIdMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id']),
      lifeAreaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}life_area_id']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final String id;
  final String title;
  final String? description;
  final String? goalId;
  final String? lifeAreaId;
  final DateTime? deadline;
  final double progress;
  final String status;
  final DateTime createdAt;
  const Project(
      {required this.id,
      required this.title,
      this.description,
      this.goalId,
      this.lifeAreaId,
      this.deadline,
      required this.progress,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || lifeAreaId != null) {
      map['life_area_id'] = Variable<String>(lifeAreaId);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['progress'] = Variable<double>(progress);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      lifeAreaId: lifeAreaId == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeAreaId),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      progress: Value(progress),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      lifeAreaId: serializer.fromJson<String?>(json['lifeAreaId']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      progress: serializer.fromJson<double>(json['progress']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'goalId': serializer.toJson<String?>(goalId),
      'lifeAreaId': serializer.toJson<String?>(lifeAreaId),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'progress': serializer.toJson<double>(progress),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Project copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> goalId = const Value.absent(),
          Value<String?> lifeAreaId = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          double? progress,
          String? status,
          DateTime? createdAt}) =>
      Project(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        goalId: goalId.present ? goalId.value : this.goalId,
        lifeAreaId: lifeAreaId.present ? lifeAreaId.value : this.lifeAreaId,
        deadline: deadline.present ? deadline.value : this.deadline,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      lifeAreaId:
          data.lifeAreaId.present ? data.lifeAreaId.value : this.lifeAreaId,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      progress: data.progress.present ? data.progress.value : this.progress,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('goalId: $goalId, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('deadline: $deadline, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, goalId, lifeAreaId,
      deadline, progress, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.goalId == this.goalId &&
          other.lifeAreaId == this.lifeAreaId &&
          other.deadline == this.deadline &&
          other.progress == this.progress &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> goalId;
  final Value<String?> lifeAreaId;
  final Value<DateTime?> deadline;
  final Value<double> progress;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.goalId = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.deadline = const Value.absent(),
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.goalId = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.deadline = const Value.absent(),
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? goalId,
    Expression<String>? lifeAreaId,
    Expression<DateTime>? deadline,
    Expression<double>? progress,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (goalId != null) 'goal_id': goalId,
      if (lifeAreaId != null) 'life_area_id': lifeAreaId,
      if (deadline != null) 'deadline': deadline,
      if (progress != null) 'progress': progress,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? goalId,
      Value<String?>? lifeAreaId,
      Value<DateTime?>? deadline,
      Value<double>? progress,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      goalId: goalId ?? this.goalId,
      lifeAreaId: lifeAreaId ?? this.lifeAreaId,
      deadline: deadline ?? this.deadline,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (lifeAreaId.present) {
      map['life_area_id'] = Variable<String>(lifeAreaId.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('goalId: $goalId, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('deadline: $deadline, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _estimatedDurationMinutesMeta =
      const VerificationMeta('estimatedDurationMinutes');
  @override
  late final GeneratedColumn<int> estimatedDurationMinutes =
      GeneratedColumn<int>('estimated_duration_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(30));
  static const VerificationMeta _actualDurationMinutesMeta =
      const VerificationMeta('actualDurationMinutes');
  @override
  late final GeneratedColumn<int> actualDurationMinutes = GeneratedColumn<int>(
      'actual_duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _scheduledStartMeta =
      const VerificationMeta('scheduledStart');
  @override
  late final GeneratedColumn<DateTime> scheduledStart =
      GeneratedColumn<DateTime>('scheduled_start', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _scheduledEndMeta =
      const VerificationMeta('scheduledEnd');
  @override
  late final GeneratedColumn<DateTime> scheduledEnd = GeneratedColumn<DateTime>(
      'scheduled_end', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isFlexibleMeta =
      const VerificationMeta('isFlexible');
  @override
  late final GeneratedColumn<bool> isFlexible = GeneratedColumn<bool>(
      'is_flexible', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_flexible" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isCommitmentMeta =
      const VerificationMeta('isCommitment');
  @override
  late final GeneratedColumn<bool> isCommitment = GeneratedColumn<bool>(
      'is_commitment', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_commitment" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _energyLevelMeta =
      const VerificationMeta('energyLevel');
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
      'energy_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(2));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(2));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lifeAreaIdMeta =
      const VerificationMeta('lifeAreaId');
  @override
  late final GeneratedColumn<String> lifeAreaId = GeneratedColumn<String>(
      'life_area_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _parentTaskIdMeta =
      const VerificationMeta('parentTaskId');
  @override
  late final GeneratedColumn<String> parentTaskId = GeneratedColumn<String>(
      'parent_task_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recurrenceRuleMeta =
      const VerificationMeta('recurrenceRule');
  @override
  late final GeneratedColumn<String> recurrenceRule = GeneratedColumn<String>(
      'recurrence_rule', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _postponementCountMeta =
      const VerificationMeta('postponementCount');
  @override
  late final GeneratedColumn<int> postponementCount = GeneratedColumn<int>(
      'postponement_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        status,
        priority,
        estimatedDurationMinutes,
        actualDurationMinutes,
        scheduledStart,
        scheduledEnd,
        deadline,
        isFlexible,
        isCommitment,
        energyLevel,
        difficulty,
        projectId,
        goalId,
        lifeAreaId,
        parentTaskId,
        recurrenceRule,
        postponementCount,
        createdAt,
        updatedAt,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('estimated_duration_minutes')) {
      context.handle(
          _estimatedDurationMinutesMeta,
          estimatedDurationMinutes.isAcceptableOrUnknown(
              data['estimated_duration_minutes']!,
              _estimatedDurationMinutesMeta));
    }
    if (data.containsKey('actual_duration_minutes')) {
      context.handle(
          _actualDurationMinutesMeta,
          actualDurationMinutes.isAcceptableOrUnknown(
              data['actual_duration_minutes']!, _actualDurationMinutesMeta));
    }
    if (data.containsKey('scheduled_start')) {
      context.handle(
          _scheduledStartMeta,
          scheduledStart.isAcceptableOrUnknown(
              data['scheduled_start']!, _scheduledStartMeta));
    }
    if (data.containsKey('scheduled_end')) {
      context.handle(
          _scheduledEndMeta,
          scheduledEnd.isAcceptableOrUnknown(
              data['scheduled_end']!, _scheduledEndMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('is_flexible')) {
      context.handle(
          _isFlexibleMeta,
          isFlexible.isAcceptableOrUnknown(
              data['is_flexible']!, _isFlexibleMeta));
    }
    if (data.containsKey('is_commitment')) {
      context.handle(
          _isCommitmentMeta,
          isCommitment.isAcceptableOrUnknown(
              data['is_commitment']!, _isCommitmentMeta));
    }
    if (data.containsKey('energy_level')) {
      context.handle(
          _energyLevelMeta,
          energyLevel.isAcceptableOrUnknown(
              data['energy_level']!, _energyLevelMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('life_area_id')) {
      context.handle(
          _lifeAreaIdMeta,
          lifeAreaId.isAcceptableOrUnknown(
              data['life_area_id']!, _lifeAreaIdMeta));
    }
    if (data.containsKey('parent_task_id')) {
      context.handle(
          _parentTaskIdMeta,
          parentTaskId.isAcceptableOrUnknown(
              data['parent_task_id']!, _parentTaskIdMeta));
    }
    if (data.containsKey('recurrence_rule')) {
      context.handle(
          _recurrenceRuleMeta,
          recurrenceRule.isAcceptableOrUnknown(
              data['recurrence_rule']!, _recurrenceRuleMeta));
    }
    if (data.containsKey('postponement_count')) {
      context.handle(
          _postponementCountMeta,
          postponementCount.isAcceptableOrUnknown(
              data['postponement_count']!, _postponementCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      estimatedDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}estimated_duration_minutes'])!,
      actualDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}actual_duration_minutes'])!,
      scheduledStart: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_start']),
      scheduledEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_end']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      isFlexible: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_flexible'])!,
      isCommitment: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_commitment'])!,
      energyLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_level'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}difficulty'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id']),
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id']),
      lifeAreaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}life_area_id']),
      parentTaskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_task_id']),
      recurrenceRule: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurrence_rule']),
      postponementCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}postponement_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String title;
  final String? description;
  final String status;
  final String priority;
  final int estimatedDurationMinutes;
  final int actualDurationMinutes;
  final DateTime? scheduledStart;
  final DateTime? scheduledEnd;
  final DateTime? deadline;
  final bool isFlexible;
  final bool isCommitment;
  final int energyLevel;
  final int difficulty;
  final String? projectId;
  final String? goalId;
  final String? lifeAreaId;
  final String? parentTaskId;
  final String? recurrenceRule;
  final int postponementCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const Task(
      {required this.id,
      required this.title,
      this.description,
      required this.status,
      required this.priority,
      required this.estimatedDurationMinutes,
      required this.actualDurationMinutes,
      this.scheduledStart,
      this.scheduledEnd,
      this.deadline,
      required this.isFlexible,
      required this.isCommitment,
      required this.energyLevel,
      required this.difficulty,
      this.projectId,
      this.goalId,
      this.lifeAreaId,
      this.parentTaskId,
      this.recurrenceRule,
      required this.postponementCount,
      required this.createdAt,
      required this.updatedAt,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    map['estimated_duration_minutes'] = Variable<int>(estimatedDurationMinutes);
    map['actual_duration_minutes'] = Variable<int>(actualDurationMinutes);
    if (!nullToAbsent || scheduledStart != null) {
      map['scheduled_start'] = Variable<DateTime>(scheduledStart);
    }
    if (!nullToAbsent || scheduledEnd != null) {
      map['scheduled_end'] = Variable<DateTime>(scheduledEnd);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['is_flexible'] = Variable<bool>(isFlexible);
    map['is_commitment'] = Variable<bool>(isCommitment);
    map['energy_level'] = Variable<int>(energyLevel);
    map['difficulty'] = Variable<int>(difficulty);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || lifeAreaId != null) {
      map['life_area_id'] = Variable<String>(lifeAreaId);
    }
    if (!nullToAbsent || parentTaskId != null) {
      map['parent_task_id'] = Variable<String>(parentTaskId);
    }
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    map['postponement_count'] = Variable<int>(postponementCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      priority: Value(priority),
      estimatedDurationMinutes: Value(estimatedDurationMinutes),
      actualDurationMinutes: Value(actualDurationMinutes),
      scheduledStart: scheduledStart == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledStart),
      scheduledEnd: scheduledEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledEnd),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      isFlexible: Value(isFlexible),
      isCommitment: Value(isCommitment),
      energyLevel: Value(energyLevel),
      difficulty: Value(difficulty),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      lifeAreaId: lifeAreaId == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeAreaId),
      parentTaskId: parentTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTaskId),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      postponementCount: Value(postponementCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      estimatedDurationMinutes:
          serializer.fromJson<int>(json['estimatedDurationMinutes']),
      actualDurationMinutes:
          serializer.fromJson<int>(json['actualDurationMinutes']),
      scheduledStart: serializer.fromJson<DateTime?>(json['scheduledStart']),
      scheduledEnd: serializer.fromJson<DateTime?>(json['scheduledEnd']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      isFlexible: serializer.fromJson<bool>(json['isFlexible']),
      isCommitment: serializer.fromJson<bool>(json['isCommitment']),
      energyLevel: serializer.fromJson<int>(json['energyLevel']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      lifeAreaId: serializer.fromJson<String?>(json['lifeAreaId']),
      parentTaskId: serializer.fromJson<String?>(json['parentTaskId']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrenceRule']),
      postponementCount: serializer.fromJson<int>(json['postponementCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'estimatedDurationMinutes':
          serializer.toJson<int>(estimatedDurationMinutes),
      'actualDurationMinutes': serializer.toJson<int>(actualDurationMinutes),
      'scheduledStart': serializer.toJson<DateTime?>(scheduledStart),
      'scheduledEnd': serializer.toJson<DateTime?>(scheduledEnd),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'isFlexible': serializer.toJson<bool>(isFlexible),
      'isCommitment': serializer.toJson<bool>(isCommitment),
      'energyLevel': serializer.toJson<int>(energyLevel),
      'difficulty': serializer.toJson<int>(difficulty),
      'projectId': serializer.toJson<String?>(projectId),
      'goalId': serializer.toJson<String?>(goalId),
      'lifeAreaId': serializer.toJson<String?>(lifeAreaId),
      'parentTaskId': serializer.toJson<String?>(parentTaskId),
      'recurrenceRule': serializer.toJson<String?>(recurrenceRule),
      'postponementCount': serializer.toJson<int>(postponementCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Task copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          String? status,
          String? priority,
          int? estimatedDurationMinutes,
          int? actualDurationMinutes,
          Value<DateTime?> scheduledStart = const Value.absent(),
          Value<DateTime?> scheduledEnd = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          bool? isFlexible,
          bool? isCommitment,
          int? energyLevel,
          int? difficulty,
          Value<String?> projectId = const Value.absent(),
          Value<String?> goalId = const Value.absent(),
          Value<String?> lifeAreaId = const Value.absent(),
          Value<String?> parentTaskId = const Value.absent(),
          Value<String?> recurrenceRule = const Value.absent(),
          int? postponementCount,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        estimatedDurationMinutes:
            estimatedDurationMinutes ?? this.estimatedDurationMinutes,
        actualDurationMinutes:
            actualDurationMinutes ?? this.actualDurationMinutes,
        scheduledStart:
            scheduledStart.present ? scheduledStart.value : this.scheduledStart,
        scheduledEnd:
            scheduledEnd.present ? scheduledEnd.value : this.scheduledEnd,
        deadline: deadline.present ? deadline.value : this.deadline,
        isFlexible: isFlexible ?? this.isFlexible,
        isCommitment: isCommitment ?? this.isCommitment,
        energyLevel: energyLevel ?? this.energyLevel,
        difficulty: difficulty ?? this.difficulty,
        projectId: projectId.present ? projectId.value : this.projectId,
        goalId: goalId.present ? goalId.value : this.goalId,
        lifeAreaId: lifeAreaId.present ? lifeAreaId.value : this.lifeAreaId,
        parentTaskId:
            parentTaskId.present ? parentTaskId.value : this.parentTaskId,
        recurrenceRule:
            recurrenceRule.present ? recurrenceRule.value : this.recurrenceRule,
        postponementCount: postponementCount ?? this.postponementCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      estimatedDurationMinutes: data.estimatedDurationMinutes.present
          ? data.estimatedDurationMinutes.value
          : this.estimatedDurationMinutes,
      actualDurationMinutes: data.actualDurationMinutes.present
          ? data.actualDurationMinutes.value
          : this.actualDurationMinutes,
      scheduledStart: data.scheduledStart.present
          ? data.scheduledStart.value
          : this.scheduledStart,
      scheduledEnd: data.scheduledEnd.present
          ? data.scheduledEnd.value
          : this.scheduledEnd,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      isFlexible:
          data.isFlexible.present ? data.isFlexible.value : this.isFlexible,
      isCommitment: data.isCommitment.present
          ? data.isCommitment.value
          : this.isCommitment,
      energyLevel:
          data.energyLevel.present ? data.energyLevel.value : this.energyLevel,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      lifeAreaId:
          data.lifeAreaId.present ? data.lifeAreaId.value : this.lifeAreaId,
      parentTaskId: data.parentTaskId.present
          ? data.parentTaskId.value
          : this.parentTaskId,
      recurrenceRule: data.recurrenceRule.present
          ? data.recurrenceRule.value
          : this.recurrenceRule,
      postponementCount: data.postponementCount.present
          ? data.postponementCount.value
          : this.postponementCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('scheduledEnd: $scheduledEnd, ')
          ..write('deadline: $deadline, ')
          ..write('isFlexible: $isFlexible, ')
          ..write('isCommitment: $isCommitment, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('difficulty: $difficulty, ')
          ..write('projectId: $projectId, ')
          ..write('goalId: $goalId, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('parentTaskId: $parentTaskId, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('postponementCount: $postponementCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        description,
        status,
        priority,
        estimatedDurationMinutes,
        actualDurationMinutes,
        scheduledStart,
        scheduledEnd,
        deadline,
        isFlexible,
        isCommitment,
        energyLevel,
        difficulty,
        projectId,
        goalId,
        lifeAreaId,
        parentTaskId,
        recurrenceRule,
        postponementCount,
        createdAt,
        updatedAt,
        completedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.estimatedDurationMinutes == this.estimatedDurationMinutes &&
          other.actualDurationMinutes == this.actualDurationMinutes &&
          other.scheduledStart == this.scheduledStart &&
          other.scheduledEnd == this.scheduledEnd &&
          other.deadline == this.deadline &&
          other.isFlexible == this.isFlexible &&
          other.isCommitment == this.isCommitment &&
          other.energyLevel == this.energyLevel &&
          other.difficulty == this.difficulty &&
          other.projectId == this.projectId &&
          other.goalId == this.goalId &&
          other.lifeAreaId == this.lifeAreaId &&
          other.parentTaskId == this.parentTaskId &&
          other.recurrenceRule == this.recurrenceRule &&
          other.postponementCount == this.postponementCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> status;
  final Value<String> priority;
  final Value<int> estimatedDurationMinutes;
  final Value<int> actualDurationMinutes;
  final Value<DateTime?> scheduledStart;
  final Value<DateTime?> scheduledEnd;
  final Value<DateTime?> deadline;
  final Value<bool> isFlexible;
  final Value<bool> isCommitment;
  final Value<int> energyLevel;
  final Value<int> difficulty;
  final Value<String?> projectId;
  final Value<String?> goalId;
  final Value<String?> lifeAreaId;
  final Value<String?> parentTaskId;
  final Value<String?> recurrenceRule;
  final Value<int> postponementCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.actualDurationMinutes = const Value.absent(),
    this.scheduledStart = const Value.absent(),
    this.scheduledEnd = const Value.absent(),
    this.deadline = const Value.absent(),
    this.isFlexible = const Value.absent(),
    this.isCommitment = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.projectId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.parentTaskId = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.postponementCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.actualDurationMinutes = const Value.absent(),
    this.scheduledStart = const Value.absent(),
    this.scheduledEnd = const Value.absent(),
    this.deadline = const Value.absent(),
    this.isFlexible = const Value.absent(),
    this.isCommitment = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.projectId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.parentTaskId = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.postponementCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<int>? estimatedDurationMinutes,
    Expression<int>? actualDurationMinutes,
    Expression<DateTime>? scheduledStart,
    Expression<DateTime>? scheduledEnd,
    Expression<DateTime>? deadline,
    Expression<bool>? isFlexible,
    Expression<bool>? isCommitment,
    Expression<int>? energyLevel,
    Expression<int>? difficulty,
    Expression<String>? projectId,
    Expression<String>? goalId,
    Expression<String>? lifeAreaId,
    Expression<String>? parentTaskId,
    Expression<String>? recurrenceRule,
    Expression<int>? postponementCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (estimatedDurationMinutes != null)
        'estimated_duration_minutes': estimatedDurationMinutes,
      if (actualDurationMinutes != null)
        'actual_duration_minutes': actualDurationMinutes,
      if (scheduledStart != null) 'scheduled_start': scheduledStart,
      if (scheduledEnd != null) 'scheduled_end': scheduledEnd,
      if (deadline != null) 'deadline': deadline,
      if (isFlexible != null) 'is_flexible': isFlexible,
      if (isCommitment != null) 'is_commitment': isCommitment,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (difficulty != null) 'difficulty': difficulty,
      if (projectId != null) 'project_id': projectId,
      if (goalId != null) 'goal_id': goalId,
      if (lifeAreaId != null) 'life_area_id': lifeAreaId,
      if (parentTaskId != null) 'parent_task_id': parentTaskId,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (postponementCount != null) 'postponement_count': postponementCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? status,
      Value<String>? priority,
      Value<int>? estimatedDurationMinutes,
      Value<int>? actualDurationMinutes,
      Value<DateTime?>? scheduledStart,
      Value<DateTime?>? scheduledEnd,
      Value<DateTime?>? deadline,
      Value<bool>? isFlexible,
      Value<bool>? isCommitment,
      Value<int>? energyLevel,
      Value<int>? difficulty,
      Value<String?>? projectId,
      Value<String?>? goalId,
      Value<String?>? lifeAreaId,
      Value<String?>? parentTaskId,
      Value<String?>? recurrenceRule,
      Value<int>? postponementCount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      actualDurationMinutes:
          actualDurationMinutes ?? this.actualDurationMinutes,
      scheduledStart: scheduledStart ?? this.scheduledStart,
      scheduledEnd: scheduledEnd ?? this.scheduledEnd,
      deadline: deadline ?? this.deadline,
      isFlexible: isFlexible ?? this.isFlexible,
      isCommitment: isCommitment ?? this.isCommitment,
      energyLevel: energyLevel ?? this.energyLevel,
      difficulty: difficulty ?? this.difficulty,
      projectId: projectId ?? this.projectId,
      goalId: goalId ?? this.goalId,
      lifeAreaId: lifeAreaId ?? this.lifeAreaId,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      postponementCount: postponementCount ?? this.postponementCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (estimatedDurationMinutes.present) {
      map['estimated_duration_minutes'] =
          Variable<int>(estimatedDurationMinutes.value);
    }
    if (actualDurationMinutes.present) {
      map['actual_duration_minutes'] =
          Variable<int>(actualDurationMinutes.value);
    }
    if (scheduledStart.present) {
      map['scheduled_start'] = Variable<DateTime>(scheduledStart.value);
    }
    if (scheduledEnd.present) {
      map['scheduled_end'] = Variable<DateTime>(scheduledEnd.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (isFlexible.present) {
      map['is_flexible'] = Variable<bool>(isFlexible.value);
    }
    if (isCommitment.present) {
      map['is_commitment'] = Variable<bool>(isCommitment.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (lifeAreaId.present) {
      map['life_area_id'] = Variable<String>(lifeAreaId.value);
    }
    if (parentTaskId.present) {
      map['parent_task_id'] = Variable<String>(parentTaskId.value);
    }
    if (recurrenceRule.present) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule.value);
    }
    if (postponementCount.present) {
      map['postponement_count'] = Variable<int>(postponementCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('scheduledEnd: $scheduledEnd, ')
          ..write('deadline: $deadline, ')
          ..write('isFlexible: $isFlexible, ')
          ..write('isCommitment: $isCommitment, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('difficulty: $difficulty, ')
          ..write('projectId: $projectId, ')
          ..write('goalId: $goalId, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('parentTaskId: $parentTaskId, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('postponementCount: $postponementCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubtasksTable extends Subtasks with TableInfo<$SubtasksTable, Subtask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubtasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, title, isCompleted, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subtasks';
  @override
  VerificationContext validateIntegrity(Insertable<Subtask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subtask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subtask(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $SubtasksTable createAlias(String alias) {
    return $SubtasksTable(attachedDatabase, alias);
  }
}

class Subtask extends DataClass implements Insertable<Subtask> {
  final String id;
  final String taskId;
  final String title;
  final bool isCompleted;
  final int orderIndex;
  const Subtask(
      {required this.id,
      required this.taskId,
      required this.title,
      required this.isCompleted,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['title'] = Variable<String>(title);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  SubtasksCompanion toCompanion(bool nullToAbsent) {
    return SubtasksCompanion(
      id: Value(id),
      taskId: Value(taskId),
      title: Value(title),
      isCompleted: Value(isCompleted),
      orderIndex: Value(orderIndex),
    );
  }

  factory Subtask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subtask(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      title: serializer.fromJson<String>(json['title']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'title': serializer.toJson<String>(title),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  Subtask copyWith(
          {String? id,
          String? taskId,
          String? title,
          bool? isCompleted,
          int? orderIndex}) =>
      Subtask(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  Subtask copyWithCompanion(SubtasksCompanion data) {
    return Subtask(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      title: data.title.present ? data.title.value : this.title,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subtask(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, title, isCompleted, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subtask &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.title == this.title &&
          other.isCompleted == this.isCompleted &&
          other.orderIndex == this.orderIndex);
}

class SubtasksCompanion extends UpdateCompanion<Subtask> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> title;
  final Value<bool> isCompleted;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const SubtasksCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.title = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubtasksCompanion.insert({
    required String id,
    required String taskId,
    required String title,
    this.isCompleted = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        title = Value(title);
  static Insertable<Subtask> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? title,
    Expression<bool>? isCompleted,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (title != null) 'title': title,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubtasksCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<String>? title,
      Value<bool>? isCompleted,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return SubtasksCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubtasksCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskHistoriesTable extends TaskHistories
    with TableInfo<$TaskHistoriesTable, TaskHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionTypeMeta =
      const VerificationMeta('actionType');
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
      'action_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, actionType, timestamp, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_histories';
  @override
  VerificationContext validateIntegrity(Insertable<TaskHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('action_type')) {
      context.handle(
          _actionTypeMeta,
          actionType.isAcceptableOrUnknown(
              data['action_type']!, _actionTypeMeta));
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskHistory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      actionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $TaskHistoriesTable createAlias(String alias) {
    return $TaskHistoriesTable(attachedDatabase, alias);
  }
}

class TaskHistory extends DataClass implements Insertable<TaskHistory> {
  final String id;
  final String taskId;
  final String actionType;
  final DateTime timestamp;
  final String? notes;
  const TaskHistory(
      {required this.id,
      required this.taskId,
      required this.actionType,
      required this.timestamp,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['action_type'] = Variable<String>(actionType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TaskHistoriesCompanion toCompanion(bool nullToAbsent) {
    return TaskHistoriesCompanion(
      id: Value(id),
      taskId: Value(taskId),
      actionType: Value(actionType),
      timestamp: Value(timestamp),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory TaskHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskHistory(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      actionType: serializer.fromJson<String>(json['actionType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'actionType': serializer.toJson<String>(actionType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  TaskHistory copyWith(
          {String? id,
          String? taskId,
          String? actionType,
          DateTime? timestamp,
          Value<String?> notes = const Value.absent()}) =>
      TaskHistory(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        actionType: actionType ?? this.actionType,
        timestamp: timestamp ?? this.timestamp,
        notes: notes.present ? notes.value : this.notes,
      );
  TaskHistory copyWithCompanion(TaskHistoriesCompanion data) {
    return TaskHistory(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      actionType:
          data.actionType.present ? data.actionType.value : this.actionType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskHistory(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('actionType: $actionType, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, actionType, timestamp, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskHistory &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.actionType == this.actionType &&
          other.timestamp == this.timestamp &&
          other.notes == this.notes);
}

class TaskHistoriesCompanion extends UpdateCompanion<TaskHistory> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> actionType;
  final Value<DateTime> timestamp;
  final Value<String?> notes;
  final Value<int> rowid;
  const TaskHistoriesCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.actionType = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskHistoriesCompanion.insert({
    required String id,
    required String taskId,
    required String actionType,
    this.timestamp = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        actionType = Value(actionType);
  static Insertable<TaskHistory> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? actionType,
    Expression<DateTime>? timestamp,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (actionType != null) 'action_type': actionType,
      if (timestamp != null) 'timestamp': timestamp,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskHistoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<String>? actionType,
      Value<DateTime>? timestamp,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return TaskHistoriesCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      actionType: actionType ?? this.actionType,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('actionType: $actionType, ')
          ..write('timestamp: $timestamp, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lifeAreaIdMeta =
      const VerificationMeta('lifeAreaId');
  @override
  late final GeneratedColumn<String> lifeAreaId = GeneratedColumn<String>(
      'life_area_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _frequencyTypeMeta =
      const VerificationMeta('frequencyType');
  @override
  late final GeneratedColumn<String> frequencyType = GeneratedColumn<String>(
      'frequency_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('daily'));
  static const VerificationMeta _targetDaysOfWeekMaskMeta =
      const VerificationMeta('targetDaysOfWeekMask');
  @override
  late final GeneratedColumn<int> targetDaysOfWeekMask = GeneratedColumn<int>(
      'target_days_of_week_mask', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(127));
  static const VerificationMeta _targetCountPerPeriodMeta =
      const VerificationMeta('targetCountPerPeriod');
  @override
  late final GeneratedColumn<int> targetCountPerPeriod = GeneratedColumn<int>(
      'target_count_per_period', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#3C51C2'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        lifeAreaId,
        frequencyType,
        targetDaysOfWeekMask,
        targetCountPerPeriod,
        colorHex,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('life_area_id')) {
      context.handle(
          _lifeAreaIdMeta,
          lifeAreaId.isAcceptableOrUnknown(
              data['life_area_id']!, _lifeAreaIdMeta));
    }
    if (data.containsKey('frequency_type')) {
      context.handle(
          _frequencyTypeMeta,
          frequencyType.isAcceptableOrUnknown(
              data['frequency_type']!, _frequencyTypeMeta));
    }
    if (data.containsKey('target_days_of_week_mask')) {
      context.handle(
          _targetDaysOfWeekMaskMeta,
          targetDaysOfWeekMask.isAcceptableOrUnknown(
              data['target_days_of_week_mask']!, _targetDaysOfWeekMaskMeta));
    }
    if (data.containsKey('target_count_per_period')) {
      context.handle(
          _targetCountPerPeriodMeta,
          targetCountPerPeriod.isAcceptableOrUnknown(
              data['target_count_per_period']!, _targetCountPerPeriodMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      lifeAreaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}life_area_id']),
      frequencyType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency_type'])!,
      targetDaysOfWeekMask: attachedDatabase.typeMapping.read(DriftSqlType.int,
          data['${effectivePrefix}target_days_of_week_mask'])!,
      targetCountPerPeriod: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}target_count_per_period'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String title;
  final String? description;
  final String? lifeAreaId;
  final String frequencyType;
  final int targetDaysOfWeekMask;
  final int targetCountPerPeriod;
  final String colorHex;
  final DateTime createdAt;
  const Habit(
      {required this.id,
      required this.title,
      this.description,
      this.lifeAreaId,
      required this.frequencyType,
      required this.targetDaysOfWeekMask,
      required this.targetCountPerPeriod,
      required this.colorHex,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || lifeAreaId != null) {
      map['life_area_id'] = Variable<String>(lifeAreaId);
    }
    map['frequency_type'] = Variable<String>(frequencyType);
    map['target_days_of_week_mask'] = Variable<int>(targetDaysOfWeekMask);
    map['target_count_per_period'] = Variable<int>(targetCountPerPeriod);
    map['color_hex'] = Variable<String>(colorHex);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lifeAreaId: lifeAreaId == null && nullToAbsent
          ? const Value.absent()
          : Value(lifeAreaId),
      frequencyType: Value(frequencyType),
      targetDaysOfWeekMask: Value(targetDaysOfWeekMask),
      targetCountPerPeriod: Value(targetCountPerPeriod),
      colorHex: Value(colorHex),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      lifeAreaId: serializer.fromJson<String?>(json['lifeAreaId']),
      frequencyType: serializer.fromJson<String>(json['frequencyType']),
      targetDaysOfWeekMask:
          serializer.fromJson<int>(json['targetDaysOfWeekMask']),
      targetCountPerPeriod:
          serializer.fromJson<int>(json['targetCountPerPeriod']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'lifeAreaId': serializer.toJson<String?>(lifeAreaId),
      'frequencyType': serializer.toJson<String>(frequencyType),
      'targetDaysOfWeekMask': serializer.toJson<int>(targetDaysOfWeekMask),
      'targetCountPerPeriod': serializer.toJson<int>(targetCountPerPeriod),
      'colorHex': serializer.toJson<String>(colorHex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> lifeAreaId = const Value.absent(),
          String? frequencyType,
          int? targetDaysOfWeekMask,
          int? targetCountPerPeriod,
          String? colorHex,
          DateTime? createdAt}) =>
      Habit(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        lifeAreaId: lifeAreaId.present ? lifeAreaId.value : this.lifeAreaId,
        frequencyType: frequencyType ?? this.frequencyType,
        targetDaysOfWeekMask: targetDaysOfWeekMask ?? this.targetDaysOfWeekMask,
        targetCountPerPeriod: targetCountPerPeriod ?? this.targetCountPerPeriod,
        colorHex: colorHex ?? this.colorHex,
        createdAt: createdAt ?? this.createdAt,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      lifeAreaId:
          data.lifeAreaId.present ? data.lifeAreaId.value : this.lifeAreaId,
      frequencyType: data.frequencyType.present
          ? data.frequencyType.value
          : this.frequencyType,
      targetDaysOfWeekMask: data.targetDaysOfWeekMask.present
          ? data.targetDaysOfWeekMask.value
          : this.targetDaysOfWeekMask,
      targetCountPerPeriod: data.targetCountPerPeriod.present
          ? data.targetCountPerPeriod.value
          : this.targetCountPerPeriod,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('frequencyType: $frequencyType, ')
          ..write('targetDaysOfWeekMask: $targetDaysOfWeekMask, ')
          ..write('targetCountPerPeriod: $targetCountPerPeriod, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      description,
      lifeAreaId,
      frequencyType,
      targetDaysOfWeekMask,
      targetCountPerPeriod,
      colorHex,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.lifeAreaId == this.lifeAreaId &&
          other.frequencyType == this.frequencyType &&
          other.targetDaysOfWeekMask == this.targetDaysOfWeekMask &&
          other.targetCountPerPeriod == this.targetCountPerPeriod &&
          other.colorHex == this.colorHex &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> lifeAreaId;
  final Value<String> frequencyType;
  final Value<int> targetDaysOfWeekMask;
  final Value<int> targetCountPerPeriod;
  final Value<String> colorHex;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.frequencyType = const Value.absent(),
    this.targetDaysOfWeekMask = const Value.absent(),
    this.targetCountPerPeriod = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.lifeAreaId = const Value.absent(),
    this.frequencyType = const Value.absent(),
    this.targetDaysOfWeekMask = const Value.absent(),
    this.targetCountPerPeriod = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? lifeAreaId,
    Expression<String>? frequencyType,
    Expression<int>? targetDaysOfWeekMask,
    Expression<int>? targetCountPerPeriod,
    Expression<String>? colorHex,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (lifeAreaId != null) 'life_area_id': lifeAreaId,
      if (frequencyType != null) 'frequency_type': frequencyType,
      if (targetDaysOfWeekMask != null)
        'target_days_of_week_mask': targetDaysOfWeekMask,
      if (targetCountPerPeriod != null)
        'target_count_per_period': targetCountPerPeriod,
      if (colorHex != null) 'color_hex': colorHex,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? lifeAreaId,
      Value<String>? frequencyType,
      Value<int>? targetDaysOfWeekMask,
      Value<int>? targetCountPerPeriod,
      Value<String>? colorHex,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lifeAreaId: lifeAreaId ?? this.lifeAreaId,
      frequencyType: frequencyType ?? this.frequencyType,
      targetDaysOfWeekMask: targetDaysOfWeekMask ?? this.targetDaysOfWeekMask,
      targetCountPerPeriod: targetCountPerPeriod ?? this.targetCountPerPeriod,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lifeAreaId.present) {
      map['life_area_id'] = Variable<String>(lifeAreaId.value);
    }
    if (frequencyType.present) {
      map['frequency_type'] = Variable<String>(frequencyType.value);
    }
    if (targetDaysOfWeekMask.present) {
      map['target_days_of_week_mask'] =
          Variable<int>(targetDaysOfWeekMask.value);
    }
    if (targetCountPerPeriod.present) {
      map['target_count_per_period'] =
          Variable<int>(targetCountPerPeriod.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('lifeAreaId: $lifeAreaId, ')
          ..write('frequencyType: $frequencyType, ')
          ..write('targetDaysOfWeekMask: $targetDaysOfWeekMask, ')
          ..write('targetCountPerPeriod: $targetCountPerPeriod, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitOccurrencesTable extends HabitOccurrences
    with TableInfo<$HabitOccurrencesTable, HabitOccurrence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitOccurrencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _valueCountMeta =
      const VerificationMeta('valueCount');
  @override
  late final GeneratedColumn<int> valueCount = GeneratedColumn<int>(
      'value_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, habitId, date, isCompleted, valueCount, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_occurrences';
  @override
  VerificationContext validateIntegrity(Insertable<HabitOccurrence> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('value_count')) {
      context.handle(
          _valueCountMeta,
          valueCount.isAcceptableOrUnknown(
              data['value_count']!, _valueCountMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitOccurrence map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitOccurrence(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      valueCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value_count'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $HabitOccurrencesTable createAlias(String alias) {
    return $HabitOccurrencesTable(attachedDatabase, alias);
  }
}

class HabitOccurrence extends DataClass implements Insertable<HabitOccurrence> {
  final String id;
  final String habitId;
  final DateTime date;
  final bool isCompleted;
  final int valueCount;
  final String? notes;
  const HabitOccurrence(
      {required this.id,
      required this.habitId,
      required this.date,
      required this.isCompleted,
      required this.valueCount,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['date'] = Variable<DateTime>(date);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['value_count'] = Variable<int>(valueCount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  HabitOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return HabitOccurrencesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      isCompleted: Value(isCompleted),
      valueCount: Value(valueCount),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory HabitOccurrence.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitOccurrence(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      date: serializer.fromJson<DateTime>(json['date']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      valueCount: serializer.fromJson<int>(json['valueCount']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'date': serializer.toJson<DateTime>(date),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'valueCount': serializer.toJson<int>(valueCount),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  HabitOccurrence copyWith(
          {String? id,
          String? habitId,
          DateTime? date,
          bool? isCompleted,
          int? valueCount,
          Value<String?> notes = const Value.absent()}) =>
      HabitOccurrence(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        isCompleted: isCompleted ?? this.isCompleted,
        valueCount: valueCount ?? this.valueCount,
        notes: notes.present ? notes.value : this.notes,
      );
  HabitOccurrence copyWithCompanion(HabitOccurrencesCompanion data) {
    return HabitOccurrence(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      valueCount:
          data.valueCount.present ? data.valueCount.value : this.valueCount,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitOccurrence(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('valueCount: $valueCount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, date, isCompleted, valueCount, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitOccurrence &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.isCompleted == this.isCompleted &&
          other.valueCount == this.valueCount &&
          other.notes == this.notes);
}

class HabitOccurrencesCompanion extends UpdateCompanion<HabitOccurrence> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> date;
  final Value<bool> isCompleted;
  final Value<int> valueCount;
  final Value<String?> notes;
  final Value<int> rowid;
  const HabitOccurrencesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.valueCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitOccurrencesCompanion.insert({
    required String id,
    required String habitId,
    required DateTime date,
    this.isCompleted = const Value.absent(),
    this.valueCount = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        habitId = Value(habitId),
        date = Value(date);
  static Insertable<HabitOccurrence> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? date,
    Expression<bool>? isCompleted,
    Expression<int>? valueCount,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (valueCount != null) 'value_count': valueCount,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitOccurrencesCompanion copyWith(
      {Value<String>? id,
      Value<String>? habitId,
      Value<DateTime>? date,
      Value<bool>? isCompleted,
      Value<int>? valueCount,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return HabitOccurrencesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      valueCount: valueCount ?? this.valueCount,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (valueCount.present) {
      map['value_count'] = Variable<int>(valueCount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('valueCount: $valueCount, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalendarEventsTable extends CalendarEvents
    with TableInfo<$CalendarEventsTable, CalendarEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isAllDayMeta =
      const VerificationMeta('isAllDay');
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
      'is_all_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_all_day" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#3C51C2'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, startTime, endTime, isAllDay, colorHex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_events';
  @override
  VerificationContext validateIntegrity(Insertable<CalendarEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(_isAllDayMeta,
          isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalendarEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      isAllDay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_all_day'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
    );
  }

  @override
  $CalendarEventsTable createAlias(String alias) {
    return $CalendarEventsTable(attachedDatabase, alias);
  }
}

class CalendarEvent extends DataClass implements Insertable<CalendarEvent> {
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final String colorHex;
  const CalendarEvent(
      {required this.id,
      required this.title,
      this.description,
      required this.startTime,
      required this.endTime,
      required this.isAllDay,
      required this.colorHex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['is_all_day'] = Variable<bool>(isAllDay);
    map['color_hex'] = Variable<String>(colorHex);
    return map;
  }

  CalendarEventsCompanion toCompanion(bool nullToAbsent) {
    return CalendarEventsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startTime: Value(startTime),
      endTime: Value(endTime),
      isAllDay: Value(isAllDay),
      colorHex: Value(colorHex),
    );
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarEvent(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'colorHex': serializer.toJson<String>(colorHex),
    };
  }

  CalendarEvent copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          DateTime? startTime,
          DateTime? endTime,
          bool? isAllDay,
          String? colorHex}) =>
      CalendarEvent(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isAllDay: isAllDay ?? this.isAllDay,
        colorHex: colorHex ?? this.colorHex,
      );
  CalendarEvent copyWithCompanion(CalendarEventsCompanion data) {
    return CalendarEvent(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEvent(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, description, startTime, endTime, isAllDay, colorHex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarEvent &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.isAllDay == this.isAllDay &&
          other.colorHex == this.colorHex);
}

class CalendarEventsCompanion extends UpdateCompanion<CalendarEvent> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<bool> isAllDay;
  final Value<String> colorHex;
  final Value<int> rowid;
  const CalendarEventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalendarEventsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required DateTime startTime,
    required DateTime endTime,
    this.isAllDay = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<CalendarEvent> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<bool>? isAllDay,
    Expression<String>? colorHex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (colorHex != null) 'color_hex': colorHex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalendarEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<bool>? isAllDay,
      Value<String>? colorHex,
      Value<int>? rowid}) {
    return CalendarEventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAllDay: isAllDay ?? this.isAllDay,
      colorHex: colorHex ?? this.colorHex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('colorHex: $colorHex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeBlocksTable extends TimeBlocks
    with TableInfo<$TimeBlocksTable, TimeBlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('user'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('scheduled'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, title, startTime, endTime, source, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<TimeBlock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeBlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeBlock(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $TimeBlocksTable createAlias(String alias) {
    return $TimeBlocksTable(attachedDatabase, alias);
  }
}

class TimeBlock extends DataClass implements Insertable<TimeBlock> {
  final String id;
  final String? taskId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String source;
  final String status;
  const TimeBlock(
      {required this.id,
      this.taskId,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.source,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['source'] = Variable<String>(source);
    map['status'] = Variable<String>(status);
    return map;
  }

  TimeBlocksCompanion toCompanion(bool nullToAbsent) {
    return TimeBlocksCompanion(
      id: Value(id),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      title: Value(title),
      startTime: Value(startTime),
      endTime: Value(endTime),
      source: Value(source),
      status: Value(status),
    );
  }

  factory TimeBlock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeBlock(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      source: serializer.fromJson<String>(json['source']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String?>(taskId),
      'title': serializer.toJson<String>(title),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'source': serializer.toJson<String>(source),
      'status': serializer.toJson<String>(status),
    };
  }

  TimeBlock copyWith(
          {String? id,
          Value<String?> taskId = const Value.absent(),
          String? title,
          DateTime? startTime,
          DateTime? endTime,
          String? source,
          String? status}) =>
      TimeBlock(
        id: id ?? this.id,
        taskId: taskId.present ? taskId.value : this.taskId,
        title: title ?? this.title,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        source: source ?? this.source,
        status: status ?? this.status,
      );
  TimeBlock copyWithCompanion(TimeBlocksCompanion data) {
    return TimeBlock(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      source: data.source.present ? data.source.value : this.source,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeBlock(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('source: $source, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskId, title, startTime, endTime, source, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeBlock &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.source == this.source &&
          other.status == this.status);
}

class TimeBlocksCompanion extends UpdateCompanion<TimeBlock> {
  final Value<String> id;
  final Value<String?> taskId;
  final Value<String> title;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> source;
  final Value<String> status;
  final Value<int> rowid;
  const TimeBlocksCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.source = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeBlocksCompanion.insert({
    required String id,
    this.taskId = const Value.absent(),
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    this.source = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<TimeBlock> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? title,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? source,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (source != null) 'source': source,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeBlocksCompanion copyWith(
      {Value<String>? id,
      Value<String?>? taskId,
      Value<String>? title,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<String>? source,
      Value<String>? status,
      Value<int>? rowid}) {
    return TimeBlocksCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      source: source ?? this.source,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeBlocksCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FocusSessionsTable extends FocusSessions
    with TableInfo<$FocusSessionsTable, FocusSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endedAtMeta =
      const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
      'ended_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _plannedDurationMinutesMeta =
      const VerificationMeta('plannedDurationMinutes');
  @override
  late final GeneratedColumn<int> plannedDurationMinutes = GeneratedColumn<int>(
      'planned_duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _actualDurationMinutesMeta =
      const VerificationMeta('actualDurationMinutes');
  @override
  late final GeneratedColumn<int> actualDurationMinutes = GeneratedColumn<int>(
      'actual_duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _interruptedCountMeta =
      const VerificationMeta('interruptedCount');
  @override
  late final GeneratedColumn<int> interruptedCount = GeneratedColumn<int>(
      'interrupted_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskId,
        startedAt,
        endedAt,
        plannedDurationMinutes,
        actualDurationMinutes,
        interruptedCount,
        isCompleted,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<FocusSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(_endedAtMeta,
          endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    }
    if (data.containsKey('planned_duration_minutes')) {
      context.handle(
          _plannedDurationMinutesMeta,
          plannedDurationMinutes.isAcceptableOrUnknown(
              data['planned_duration_minutes']!, _plannedDurationMinutesMeta));
    } else if (isInserting) {
      context.missing(_plannedDurationMinutesMeta);
    }
    if (data.containsKey('actual_duration_minutes')) {
      context.handle(
          _actualDurationMinutesMeta,
          actualDurationMinutes.isAcceptableOrUnknown(
              data['actual_duration_minutes']!, _actualDurationMinutesMeta));
    }
    if (data.containsKey('interrupted_count')) {
      context.handle(
          _interruptedCountMeta,
          interruptedCount.isAcceptableOrUnknown(
              data['interrupted_count']!, _interruptedCountMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at']),
      plannedDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}planned_duration_minutes'])!,
      actualDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}actual_duration_minutes'])!,
      interruptedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interrupted_count'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $FocusSessionsTable createAlias(String alias) {
    return $FocusSessionsTable(attachedDatabase, alias);
  }
}

class FocusSession extends DataClass implements Insertable<FocusSession> {
  final String id;
  final String? taskId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int plannedDurationMinutes;
  final int actualDurationMinutes;
  final int interruptedCount;
  final bool isCompleted;
  final String? notes;
  const FocusSession(
      {required this.id,
      this.taskId,
      required this.startedAt,
      this.endedAt,
      required this.plannedDurationMinutes,
      required this.actualDurationMinutes,
      required this.interruptedCount,
      required this.isCompleted,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['planned_duration_minutes'] = Variable<int>(plannedDurationMinutes);
    map['actual_duration_minutes'] = Variable<int>(actualDurationMinutes);
    map['interrupted_count'] = Variable<int>(interruptedCount);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FocusSessionsCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsCompanion(
      id: Value(id),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      plannedDurationMinutes: Value(plannedDurationMinutes),
      actualDurationMinutes: Value(actualDurationMinutes),
      interruptedCount: Value(interruptedCount),
      isCompleted: Value(isCompleted),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory FocusSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusSession(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      plannedDurationMinutes:
          serializer.fromJson<int>(json['plannedDurationMinutes']),
      actualDurationMinutes:
          serializer.fromJson<int>(json['actualDurationMinutes']),
      interruptedCount: serializer.fromJson<int>(json['interruptedCount']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String?>(taskId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'plannedDurationMinutes': serializer.toJson<int>(plannedDurationMinutes),
      'actualDurationMinutes': serializer.toJson<int>(actualDurationMinutes),
      'interruptedCount': serializer.toJson<int>(interruptedCount),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FocusSession copyWith(
          {String? id,
          Value<String?> taskId = const Value.absent(),
          DateTime? startedAt,
          Value<DateTime?> endedAt = const Value.absent(),
          int? plannedDurationMinutes,
          int? actualDurationMinutes,
          int? interruptedCount,
          bool? isCompleted,
          Value<String?> notes = const Value.absent()}) =>
      FocusSession(
        id: id ?? this.id,
        taskId: taskId.present ? taskId.value : this.taskId,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt.present ? endedAt.value : this.endedAt,
        plannedDurationMinutes:
            plannedDurationMinutes ?? this.plannedDurationMinutes,
        actualDurationMinutes:
            actualDurationMinutes ?? this.actualDurationMinutes,
        interruptedCount: interruptedCount ?? this.interruptedCount,
        isCompleted: isCompleted ?? this.isCompleted,
        notes: notes.present ? notes.value : this.notes,
      );
  FocusSession copyWithCompanion(FocusSessionsCompanion data) {
    return FocusSession(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      plannedDurationMinutes: data.plannedDurationMinutes.present
          ? data.plannedDurationMinutes.value
          : this.plannedDurationMinutes,
      actualDurationMinutes: data.actualDurationMinutes.present
          ? data.actualDurationMinutes.value
          : this.actualDurationMinutes,
      interruptedCount: data.interruptedCount.present
          ? data.interruptedCount.value
          : this.interruptedCount,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusSession(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedDurationMinutes: $plannedDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('interruptedCount: $interruptedCount, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      taskId,
      startedAt,
      endedAt,
      plannedDurationMinutes,
      actualDurationMinutes,
      interruptedCount,
      isCompleted,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSession &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.plannedDurationMinutes == this.plannedDurationMinutes &&
          other.actualDurationMinutes == this.actualDurationMinutes &&
          other.interruptedCount == this.interruptedCount &&
          other.isCompleted == this.isCompleted &&
          other.notes == this.notes);
}

class FocusSessionsCompanion extends UpdateCompanion<FocusSession> {
  final Value<String> id;
  final Value<String?> taskId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> plannedDurationMinutes;
  final Value<int> actualDurationMinutes;
  final Value<int> interruptedCount;
  final Value<bool> isCompleted;
  final Value<String?> notes;
  final Value<int> rowid;
  const FocusSessionsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.plannedDurationMinutes = const Value.absent(),
    this.actualDurationMinutes = const Value.absent(),
    this.interruptedCount = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FocusSessionsCompanion.insert({
    required String id,
    this.taskId = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required int plannedDurationMinutes,
    this.actualDurationMinutes = const Value.absent(),
    this.interruptedCount = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        startedAt = Value(startedAt),
        plannedDurationMinutes = Value(plannedDurationMinutes);
  static Insertable<FocusSession> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? plannedDurationMinutes,
    Expression<int>? actualDurationMinutes,
    Expression<int>? interruptedCount,
    Expression<bool>? isCompleted,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (plannedDurationMinutes != null)
        'planned_duration_minutes': plannedDurationMinutes,
      if (actualDurationMinutes != null)
        'actual_duration_minutes': actualDurationMinutes,
      if (interruptedCount != null) 'interrupted_count': interruptedCount,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FocusSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? taskId,
      Value<DateTime>? startedAt,
      Value<DateTime?>? endedAt,
      Value<int>? plannedDurationMinutes,
      Value<int>? actualDurationMinutes,
      Value<int>? interruptedCount,
      Value<bool>? isCompleted,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return FocusSessionsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      plannedDurationMinutes:
          plannedDurationMinutes ?? this.plannedDurationMinutes,
      actualDurationMinutes:
          actualDurationMinutes ?? this.actualDurationMinutes,
      interruptedCount: interruptedCount ?? this.interruptedCount,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (plannedDurationMinutes.present) {
      map['planned_duration_minutes'] =
          Variable<int>(plannedDurationMinutes.value);
    }
    if (actualDurationMinutes.present) {
      map['actual_duration_minutes'] =
          Variable<int>(actualDurationMinutes.value);
    }
    if (interruptedCount.present) {
      map['interrupted_count'] = Variable<int>(interruptedCount.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedDurationMinutes: $plannedDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('interruptedCount: $interruptedCount, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _folderNameMeta =
      const VerificationMeta('folderName');
  @override
  late final GeneratedColumn<String> folderName = GeneratedColumn<String>(
      'folder_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('General'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, folderName, projectId, goalId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('folder_name')) {
      context.handle(
          _folderNameMeta,
          folderName.isAcceptableOrUnknown(
              data['folder_name']!, _folderNameMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      folderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folder_name'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id']),
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String title;
  final String folderName;
  final String? projectId;
  final String? goalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Note(
      {required this.id,
      required this.title,
      required this.folderName,
      this.projectId,
      this.goalId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['folder_name'] = Variable<String>(folderName);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      folderName: Value(folderName),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      folderName: serializer.fromJson<String>(json['folderName']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'folderName': serializer.toJson<String>(folderName),
      'projectId': serializer.toJson<String?>(projectId),
      'goalId': serializer.toJson<String?>(goalId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Note copyWith(
          {String? id,
          String? title,
          String? folderName,
          Value<String?> projectId = const Value.absent(),
          Value<String?> goalId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        folderName: folderName ?? this.folderName,
        projectId: projectId.present ? projectId.value : this.projectId,
        goalId: goalId.present ? goalId.value : this.goalId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      folderName:
          data.folderName.present ? data.folderName.value : this.folderName,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('folderName: $folderName, ')
          ..write('projectId: $projectId, ')
          ..write('goalId: $goalId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, folderName, projectId, goalId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.folderName == this.folderName &&
          other.projectId == this.projectId &&
          other.goalId == this.goalId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> folderName;
  final Value<String?> projectId;
  final Value<String?> goalId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.folderName = const Value.absent(),
    this.projectId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String title,
    this.folderName = const Value.absent(),
    this.projectId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? folderName,
    Expression<String>? projectId,
    Expression<String>? goalId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (folderName != null) 'folder_name': folderName,
      if (projectId != null) 'project_id': projectId,
      if (goalId != null) 'goal_id': goalId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? folderName,
      Value<String?>? projectId,
      Value<String?>? goalId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      folderName: folderName ?? this.folderName,
      projectId: projectId ?? this.projectId,
      goalId: goalId ?? this.goalId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (folderName.present) {
      map['folder_name'] = Variable<String>(folderName.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('folderName: $folderName, ')
          ..write('projectId: $projectId, ')
          ..write('goalId: $goalId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoteBlocksTable extends NoteBlocks
    with TableInfo<$NoteBlocksTable, NoteBlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _blockTypeMeta =
      const VerificationMeta('blockType');
  @override
  late final GeneratedColumn<String> blockType = GeneratedColumn<String>(
      'block_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('paragraph'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCheckedMeta =
      const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
      'is_checked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_checked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, noteId, blockType, content, isChecked, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<NoteBlock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('block_type')) {
      context.handle(_blockTypeMeta,
          blockType.isAcceptableOrUnknown(data['block_type']!, _blockTypeMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteBlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteBlock(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      blockType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}block_type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isChecked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_checked'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $NoteBlocksTable createAlias(String alias) {
    return $NoteBlocksTable(attachedDatabase, alias);
  }
}

class NoteBlock extends DataClass implements Insertable<NoteBlock> {
  final String id;
  final String noteId;
  final String blockType;
  final String content;
  final bool isChecked;
  final int orderIndex;
  const NoteBlock(
      {required this.id,
      required this.noteId,
      required this.blockType,
      required this.content,
      required this.isChecked,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['note_id'] = Variable<String>(noteId);
    map['block_type'] = Variable<String>(blockType);
    map['content'] = Variable<String>(content);
    map['is_checked'] = Variable<bool>(isChecked);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  NoteBlocksCompanion toCompanion(bool nullToAbsent) {
    return NoteBlocksCompanion(
      id: Value(id),
      noteId: Value(noteId),
      blockType: Value(blockType),
      content: Value(content),
      isChecked: Value(isChecked),
      orderIndex: Value(orderIndex),
    );
  }

  factory NoteBlock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteBlock(
      id: serializer.fromJson<String>(json['id']),
      noteId: serializer.fromJson<String>(json['noteId']),
      blockType: serializer.fromJson<String>(json['blockType']),
      content: serializer.fromJson<String>(json['content']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'noteId': serializer.toJson<String>(noteId),
      'blockType': serializer.toJson<String>(blockType),
      'content': serializer.toJson<String>(content),
      'isChecked': serializer.toJson<bool>(isChecked),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  NoteBlock copyWith(
          {String? id,
          String? noteId,
          String? blockType,
          String? content,
          bool? isChecked,
          int? orderIndex}) =>
      NoteBlock(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        blockType: blockType ?? this.blockType,
        content: content ?? this.content,
        isChecked: isChecked ?? this.isChecked,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  NoteBlock copyWithCompanion(NoteBlocksCompanion data) {
    return NoteBlock(
      id: data.id.present ? data.id.value : this.id,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      blockType: data.blockType.present ? data.blockType.value : this.blockType,
      content: data.content.present ? data.content.value : this.content,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteBlock(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('blockType: $blockType, ')
          ..write('content: $content, ')
          ..write('isChecked: $isChecked, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, noteId, blockType, content, isChecked, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteBlock &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.blockType == this.blockType &&
          other.content == this.content &&
          other.isChecked == this.isChecked &&
          other.orderIndex == this.orderIndex);
}

class NoteBlocksCompanion extends UpdateCompanion<NoteBlock> {
  final Value<String> id;
  final Value<String> noteId;
  final Value<String> blockType;
  final Value<String> content;
  final Value<bool> isChecked;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const NoteBlocksCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.blockType = const Value.absent(),
    this.content = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoteBlocksCompanion.insert({
    required String id,
    required String noteId,
    this.blockType = const Value.absent(),
    required String content,
    this.isChecked = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        noteId = Value(noteId),
        content = Value(content);
  static Insertable<NoteBlock> custom({
    Expression<String>? id,
    Expression<String>? noteId,
    Expression<String>? blockType,
    Expression<String>? content,
    Expression<bool>? isChecked,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (blockType != null) 'block_type': blockType,
      if (content != null) 'content': content,
      if (isChecked != null) 'is_checked': isChecked,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoteBlocksCompanion copyWith(
      {Value<String>? id,
      Value<String>? noteId,
      Value<String>? blockType,
      Value<String>? content,
      Value<bool>? isChecked,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return NoteBlocksCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      blockType: blockType ?? this.blockType,
      content: content ?? this.content,
      isChecked: isChecked ?? this.isChecked,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (blockType.present) {
      map['block_type'] = Variable<String>(blockType.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteBlocksCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('blockType: $blockType, ')
          ..write('content: $content, ')
          ..write('isChecked: $isChecked, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyReviewsTable extends DailyReviews
    with TableInfo<$DailyReviewsTable, DailyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _energyRatingMeta =
      const VerificationMeta('energyRating');
  @override
  late final GeneratedColumn<int> energyRating = GeneratedColumn<int>(
      'energy_rating', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _focusRatingMeta =
      const VerificationMeta('focusRating');
  @override
  late final GeneratedColumn<int> focusRating = GeneratedColumn<int>(
      'focus_rating', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _obstaclesTextMeta =
      const VerificationMeta('obstaclesText');
  @override
  late final GeneratedColumn<String> obstaclesText = GeneratedColumn<String>(
      'obstacles_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reflectionTextMeta =
      const VerificationMeta('reflectionText');
  @override
  late final GeneratedColumn<String> reflectionText = GeneratedColumn<String>(
      'reflection_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tomorrowPrioritiesJsonMeta =
      const VerificationMeta('tomorrowPrioritiesJson');
  @override
  late final GeneratedColumn<String> tomorrowPrioritiesJson =
      GeneratedColumn<String>('tomorrow_priorities_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        energyRating,
        focusRating,
        obstaclesText,
        reflectionText,
        tomorrowPrioritiesJson,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_reviews';
  @override
  VerificationContext validateIntegrity(Insertable<DailyReview> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('energy_rating')) {
      context.handle(
          _energyRatingMeta,
          energyRating.isAcceptableOrUnknown(
              data['energy_rating']!, _energyRatingMeta));
    }
    if (data.containsKey('focus_rating')) {
      context.handle(
          _focusRatingMeta,
          focusRating.isAcceptableOrUnknown(
              data['focus_rating']!, _focusRatingMeta));
    }
    if (data.containsKey('obstacles_text')) {
      context.handle(
          _obstaclesTextMeta,
          obstaclesText.isAcceptableOrUnknown(
              data['obstacles_text']!, _obstaclesTextMeta));
    }
    if (data.containsKey('reflection_text')) {
      context.handle(
          _reflectionTextMeta,
          reflectionText.isAcceptableOrUnknown(
              data['reflection_text']!, _reflectionTextMeta));
    }
    if (data.containsKey('tomorrow_priorities_json')) {
      context.handle(
          _tomorrowPrioritiesJsonMeta,
          tomorrowPrioritiesJson.isAcceptableOrUnknown(
              data['tomorrow_priorities_json']!, _tomorrowPrioritiesJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyReview(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      energyRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_rating'])!,
      focusRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}focus_rating'])!,
      obstaclesText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}obstacles_text']),
      reflectionText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reflection_text']),
      tomorrowPrioritiesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tomorrow_priorities_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DailyReviewsTable createAlias(String alias) {
    return $DailyReviewsTable(attachedDatabase, alias);
  }
}

class DailyReview extends DataClass implements Insertable<DailyReview> {
  final String id;
  final DateTime date;
  final int energyRating;
  final int focusRating;
  final String? obstaclesText;
  final String? reflectionText;
  final String? tomorrowPrioritiesJson;
  final DateTime createdAt;
  const DailyReview(
      {required this.id,
      required this.date,
      required this.energyRating,
      required this.focusRating,
      this.obstaclesText,
      this.reflectionText,
      this.tomorrowPrioritiesJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['energy_rating'] = Variable<int>(energyRating);
    map['focus_rating'] = Variable<int>(focusRating);
    if (!nullToAbsent || obstaclesText != null) {
      map['obstacles_text'] = Variable<String>(obstaclesText);
    }
    if (!nullToAbsent || reflectionText != null) {
      map['reflection_text'] = Variable<String>(reflectionText);
    }
    if (!nullToAbsent || tomorrowPrioritiesJson != null) {
      map['tomorrow_priorities_json'] =
          Variable<String>(tomorrowPrioritiesJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyReviewsCompanion toCompanion(bool nullToAbsent) {
    return DailyReviewsCompanion(
      id: Value(id),
      date: Value(date),
      energyRating: Value(energyRating),
      focusRating: Value(focusRating),
      obstaclesText: obstaclesText == null && nullToAbsent
          ? const Value.absent()
          : Value(obstaclesText),
      reflectionText: reflectionText == null && nullToAbsent
          ? const Value.absent()
          : Value(reflectionText),
      tomorrowPrioritiesJson: tomorrowPrioritiesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tomorrowPrioritiesJson),
      createdAt: Value(createdAt),
    );
  }

  factory DailyReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyReview(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      energyRating: serializer.fromJson<int>(json['energyRating']),
      focusRating: serializer.fromJson<int>(json['focusRating']),
      obstaclesText: serializer.fromJson<String?>(json['obstaclesText']),
      reflectionText: serializer.fromJson<String?>(json['reflectionText']),
      tomorrowPrioritiesJson:
          serializer.fromJson<String?>(json['tomorrowPrioritiesJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'energyRating': serializer.toJson<int>(energyRating),
      'focusRating': serializer.toJson<int>(focusRating),
      'obstaclesText': serializer.toJson<String?>(obstaclesText),
      'reflectionText': serializer.toJson<String?>(reflectionText),
      'tomorrowPrioritiesJson':
          serializer.toJson<String?>(tomorrowPrioritiesJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyReview copyWith(
          {String? id,
          DateTime? date,
          int? energyRating,
          int? focusRating,
          Value<String?> obstaclesText = const Value.absent(),
          Value<String?> reflectionText = const Value.absent(),
          Value<String?> tomorrowPrioritiesJson = const Value.absent(),
          DateTime? createdAt}) =>
      DailyReview(
        id: id ?? this.id,
        date: date ?? this.date,
        energyRating: energyRating ?? this.energyRating,
        focusRating: focusRating ?? this.focusRating,
        obstaclesText:
            obstaclesText.present ? obstaclesText.value : this.obstaclesText,
        reflectionText:
            reflectionText.present ? reflectionText.value : this.reflectionText,
        tomorrowPrioritiesJson: tomorrowPrioritiesJson.present
            ? tomorrowPrioritiesJson.value
            : this.tomorrowPrioritiesJson,
        createdAt: createdAt ?? this.createdAt,
      );
  DailyReview copyWithCompanion(DailyReviewsCompanion data) {
    return DailyReview(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      energyRating: data.energyRating.present
          ? data.energyRating.value
          : this.energyRating,
      focusRating:
          data.focusRating.present ? data.focusRating.value : this.focusRating,
      obstaclesText: data.obstaclesText.present
          ? data.obstaclesText.value
          : this.obstaclesText,
      reflectionText: data.reflectionText.present
          ? data.reflectionText.value
          : this.reflectionText,
      tomorrowPrioritiesJson: data.tomorrowPrioritiesJson.present
          ? data.tomorrowPrioritiesJson.value
          : this.tomorrowPrioritiesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyReview(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('energyRating: $energyRating, ')
          ..write('focusRating: $focusRating, ')
          ..write('obstaclesText: $obstaclesText, ')
          ..write('reflectionText: $reflectionText, ')
          ..write('tomorrowPrioritiesJson: $tomorrowPrioritiesJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, energyRating, focusRating,
      obstaclesText, reflectionText, tomorrowPrioritiesJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyReview &&
          other.id == this.id &&
          other.date == this.date &&
          other.energyRating == this.energyRating &&
          other.focusRating == this.focusRating &&
          other.obstaclesText == this.obstaclesText &&
          other.reflectionText == this.reflectionText &&
          other.tomorrowPrioritiesJson == this.tomorrowPrioritiesJson &&
          other.createdAt == this.createdAt);
}

class DailyReviewsCompanion extends UpdateCompanion<DailyReview> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> energyRating;
  final Value<int> focusRating;
  final Value<String?> obstaclesText;
  final Value<String?> reflectionText;
  final Value<String?> tomorrowPrioritiesJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DailyReviewsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.energyRating = const Value.absent(),
    this.focusRating = const Value.absent(),
    this.obstaclesText = const Value.absent(),
    this.reflectionText = const Value.absent(),
    this.tomorrowPrioritiesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyReviewsCompanion.insert({
    required String id,
    required DateTime date,
    this.energyRating = const Value.absent(),
    this.focusRating = const Value.absent(),
    this.obstaclesText = const Value.absent(),
    this.reflectionText = const Value.absent(),
    this.tomorrowPrioritiesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<DailyReview> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? energyRating,
    Expression<int>? focusRating,
    Expression<String>? obstaclesText,
    Expression<String>? reflectionText,
    Expression<String>? tomorrowPrioritiesJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (energyRating != null) 'energy_rating': energyRating,
      if (focusRating != null) 'focus_rating': focusRating,
      if (obstaclesText != null) 'obstacles_text': obstaclesText,
      if (reflectionText != null) 'reflection_text': reflectionText,
      if (tomorrowPrioritiesJson != null)
        'tomorrow_priorities_json': tomorrowPrioritiesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyReviewsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<int>? energyRating,
      Value<int>? focusRating,
      Value<String?>? obstaclesText,
      Value<String?>? reflectionText,
      Value<String?>? tomorrowPrioritiesJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DailyReviewsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      energyRating: energyRating ?? this.energyRating,
      focusRating: focusRating ?? this.focusRating,
      obstaclesText: obstaclesText ?? this.obstaclesText,
      reflectionText: reflectionText ?? this.reflectionText,
      tomorrowPrioritiesJson:
          tomorrowPrioritiesJson ?? this.tomorrowPrioritiesJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (energyRating.present) {
      map['energy_rating'] = Variable<int>(energyRating.value);
    }
    if (focusRating.present) {
      map['focus_rating'] = Variable<int>(focusRating.value);
    }
    if (obstaclesText.present) {
      map['obstacles_text'] = Variable<String>(obstaclesText.value);
    }
    if (reflectionText.present) {
      map['reflection_text'] = Variable<String>(reflectionText.value);
    }
    if (tomorrowPrioritiesJson.present) {
      map['tomorrow_priorities_json'] =
          Variable<String>(tomorrowPrioritiesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('energyRating: $energyRating, ')
          ..write('focusRating: $focusRating, ')
          ..write('obstaclesText: $obstaclesText, ')
          ..write('reflectionText: $reflectionText, ')
          ..write('tomorrowPrioritiesJson: $tomorrowPrioritiesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTable extends WeeklyReviews
    with TableInfo<$WeeklyReviewsTable, WeeklyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _reflectionTextMeta =
      const VerificationMeta('reflectionText');
  @override
  late final GeneratedColumn<String> reflectionText = GeneratedColumn<String>(
      'reflection_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _strategicAdjustmentsTextMeta =
      const VerificationMeta('strategicAdjustmentsText');
  @override
  late final GeneratedColumn<String> strategicAdjustmentsText =
      GeneratedColumn<String>('strategic_adjustments_text', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completionRateMeta =
      const VerificationMeta('completionRate');
  @override
  late final GeneratedColumn<double> completionRate = GeneratedColumn<double>(
      'completion_rate', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _commitmentReliabilityRateMeta =
      const VerificationMeta('commitmentReliabilityRate');
  @override
  late final GeneratedColumn<double> commitmentReliabilityRate =
      GeneratedColumn<double>('commitment_reliability_rate', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        startDate,
        endDate,
        reflectionText,
        strategicAdjustmentsText,
        completionRate,
        commitmentReliabilityRate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews';
  @override
  VerificationContext validateIntegrity(Insertable<WeeklyReview> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('reflection_text')) {
      context.handle(
          _reflectionTextMeta,
          reflectionText.isAcceptableOrUnknown(
              data['reflection_text']!, _reflectionTextMeta));
    }
    if (data.containsKey('strategic_adjustments_text')) {
      context.handle(
          _strategicAdjustmentsTextMeta,
          strategicAdjustmentsText.isAcceptableOrUnknown(
              data['strategic_adjustments_text']!,
              _strategicAdjustmentsTextMeta));
    }
    if (data.containsKey('completion_rate')) {
      context.handle(
          _completionRateMeta,
          completionRate.isAcceptableOrUnknown(
              data['completion_rate']!, _completionRateMeta));
    }
    if (data.containsKey('commitment_reliability_rate')) {
      context.handle(
          _commitmentReliabilityRateMeta,
          commitmentReliabilityRate.isAcceptableOrUnknown(
              data['commitment_reliability_rate']!,
              _commitmentReliabilityRateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReview(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      reflectionText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reflection_text']),
      strategicAdjustmentsText: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}strategic_adjustments_text']),
      completionRate: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}completion_rate'])!,
      commitmentReliabilityRate: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}commitment_reliability_rate'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WeeklyReviewsTable createAlias(String alias) {
    return $WeeklyReviewsTable(attachedDatabase, alias);
  }
}

class WeeklyReview extends DataClass implements Insertable<WeeklyReview> {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String? reflectionText;
  final String? strategicAdjustmentsText;
  final double completionRate;
  final double commitmentReliabilityRate;
  final DateTime createdAt;
  const WeeklyReview(
      {required this.id,
      required this.startDate,
      required this.endDate,
      this.reflectionText,
      this.strategicAdjustmentsText,
      required this.completionRate,
      required this.commitmentReliabilityRate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    if (!nullToAbsent || reflectionText != null) {
      map['reflection_text'] = Variable<String>(reflectionText);
    }
    if (!nullToAbsent || strategicAdjustmentsText != null) {
      map['strategic_adjustments_text'] =
          Variable<String>(strategicAdjustmentsText);
    }
    map['completion_rate'] = Variable<double>(completionRate);
    map['commitment_reliability_rate'] =
        Variable<double>(commitmentReliabilityRate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsCompanion(
      id: Value(id),
      startDate: Value(startDate),
      endDate: Value(endDate),
      reflectionText: reflectionText == null && nullToAbsent
          ? const Value.absent()
          : Value(reflectionText),
      strategicAdjustmentsText: strategicAdjustmentsText == null && nullToAbsent
          ? const Value.absent()
          : Value(strategicAdjustmentsText),
      completionRate: Value(completionRate),
      commitmentReliabilityRate: Value(commitmentReliabilityRate),
      createdAt: Value(createdAt),
    );
  }

  factory WeeklyReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReview(
      id: serializer.fromJson<String>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      reflectionText: serializer.fromJson<String?>(json['reflectionText']),
      strategicAdjustmentsText:
          serializer.fromJson<String?>(json['strategicAdjustmentsText']),
      completionRate: serializer.fromJson<double>(json['completionRate']),
      commitmentReliabilityRate:
          serializer.fromJson<double>(json['commitmentReliabilityRate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'reflectionText': serializer.toJson<String?>(reflectionText),
      'strategicAdjustmentsText':
          serializer.toJson<String?>(strategicAdjustmentsText),
      'completionRate': serializer.toJson<double>(completionRate),
      'commitmentReliabilityRate':
          serializer.toJson<double>(commitmentReliabilityRate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WeeklyReview copyWith(
          {String? id,
          DateTime? startDate,
          DateTime? endDate,
          Value<String?> reflectionText = const Value.absent(),
          Value<String?> strategicAdjustmentsText = const Value.absent(),
          double? completionRate,
          double? commitmentReliabilityRate,
          DateTime? createdAt}) =>
      WeeklyReview(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        reflectionText:
            reflectionText.present ? reflectionText.value : this.reflectionText,
        strategicAdjustmentsText: strategicAdjustmentsText.present
            ? strategicAdjustmentsText.value
            : this.strategicAdjustmentsText,
        completionRate: completionRate ?? this.completionRate,
        commitmentReliabilityRate:
            commitmentReliabilityRate ?? this.commitmentReliabilityRate,
        createdAt: createdAt ?? this.createdAt,
      );
  WeeklyReview copyWithCompanion(WeeklyReviewsCompanion data) {
    return WeeklyReview(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      reflectionText: data.reflectionText.present
          ? data.reflectionText.value
          : this.reflectionText,
      strategicAdjustmentsText: data.strategicAdjustmentsText.present
          ? data.strategicAdjustmentsText.value
          : this.strategicAdjustmentsText,
      completionRate: data.completionRate.present
          ? data.completionRate.value
          : this.completionRate,
      commitmentReliabilityRate: data.commitmentReliabilityRate.present
          ? data.commitmentReliabilityRate.value
          : this.commitmentReliabilityRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReview(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('reflectionText: $reflectionText, ')
          ..write('strategicAdjustmentsText: $strategicAdjustmentsText, ')
          ..write('completionRate: $completionRate, ')
          ..write('commitmentReliabilityRate: $commitmentReliabilityRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      startDate,
      endDate,
      reflectionText,
      strategicAdjustmentsText,
      completionRate,
      commitmentReliabilityRate,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReview &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.reflectionText == this.reflectionText &&
          other.strategicAdjustmentsText == this.strategicAdjustmentsText &&
          other.completionRate == this.completionRate &&
          other.commitmentReliabilityRate == this.commitmentReliabilityRate &&
          other.createdAt == this.createdAt);
}

class WeeklyReviewsCompanion extends UpdateCompanion<WeeklyReview> {
  final Value<String> id;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String?> reflectionText;
  final Value<String?> strategicAdjustmentsText;
  final Value<double> completionRate;
  final Value<double> commitmentReliabilityRate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WeeklyReviewsCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.reflectionText = const Value.absent(),
    this.strategicAdjustmentsText = const Value.absent(),
    this.completionRate = const Value.absent(),
    this.commitmentReliabilityRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsCompanion.insert({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    this.reflectionText = const Value.absent(),
    this.strategicAdjustmentsText = const Value.absent(),
    this.completionRate = const Value.absent(),
    this.commitmentReliabilityRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<WeeklyReview> custom({
    Expression<String>? id,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? reflectionText,
    Expression<String>? strategicAdjustmentsText,
    Expression<double>? completionRate,
    Expression<double>? commitmentReliabilityRate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (reflectionText != null) 'reflection_text': reflectionText,
      if (strategicAdjustmentsText != null)
        'strategic_adjustments_text': strategicAdjustmentsText,
      if (completionRate != null) 'completion_rate': completionRate,
      if (commitmentReliabilityRate != null)
        'commitment_reliability_rate': commitmentReliabilityRate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<String?>? reflectionText,
      Value<String?>? strategicAdjustmentsText,
      Value<double>? completionRate,
      Value<double>? commitmentReliabilityRate,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return WeeklyReviewsCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reflectionText: reflectionText ?? this.reflectionText,
      strategicAdjustmentsText:
          strategicAdjustmentsText ?? this.strategicAdjustmentsText,
      completionRate: completionRate ?? this.completionRate,
      commitmentReliabilityRate:
          commitmentReliabilityRate ?? this.commitmentReliabilityRate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (reflectionText.present) {
      map['reflection_text'] = Variable<String>(reflectionText.value);
    }
    if (strategicAdjustmentsText.present) {
      map['strategic_adjustments_text'] =
          Variable<String>(strategicAdjustmentsText.value);
    }
    if (completionRate.present) {
      map['completion_rate'] = Variable<double>(completionRate.value);
    }
    if (commitmentReliabilityRate.present) {
      map['commitment_reliability_rate'] =
          Variable<double>(commitmentReliabilityRate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('reflectionText: $reflectionText, ')
          ..write('strategicAdjustmentsText: $strategicAdjustmentsText, ')
          ..write('completionRate: $completionRate, ')
          ..write('commitmentReliabilityRate: $commitmentReliabilityRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BehavioralInsightsTable extends BehavioralInsights
    with TableInfo<$BehavioralInsightsTable, BehavioralInsight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BehavioralInsightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _insightTypeMeta =
      const VerificationMeta('insightType');
  @override
  late final GeneratedColumn<String> insightType = GeneratedColumn<String>(
      'insight_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
      'severity', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('info'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isDismissedMeta =
      const VerificationMeta('isDismissed');
  @override
  late final GeneratedColumn<bool> isDismissed = GeneratedColumn<bool>(
      'is_dismissed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_dismissed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, insightType, title, message, severity, timestamp, isDismissed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'behavioral_insights';
  @override
  VerificationContext validateIntegrity(Insertable<BehavioralInsight> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('insight_type')) {
      context.handle(
          _insightTypeMeta,
          insightType.isAcceptableOrUnknown(
              data['insight_type']!, _insightTypeMeta));
    } else if (isInserting) {
      context.missing(_insightTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('is_dismissed')) {
      context.handle(
          _isDismissedMeta,
          isDismissed.isAcceptableOrUnknown(
              data['is_dismissed']!, _isDismissedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BehavioralInsight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BehavioralInsight(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      insightType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insight_type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}severity'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      isDismissed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dismissed'])!,
    );
  }

  @override
  $BehavioralInsightsTable createAlias(String alias) {
    return $BehavioralInsightsTable(attachedDatabase, alias);
  }
}

class BehavioralInsight extends DataClass
    implements Insertable<BehavioralInsight> {
  final String id;
  final String insightType;
  final String title;
  final String message;
  final String severity;
  final DateTime timestamp;
  final bool isDismissed;
  const BehavioralInsight(
      {required this.id,
      required this.insightType,
      required this.title,
      required this.message,
      required this.severity,
      required this.timestamp,
      required this.isDismissed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['insight_type'] = Variable<String>(insightType);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['severity'] = Variable<String>(severity);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['is_dismissed'] = Variable<bool>(isDismissed);
    return map;
  }

  BehavioralInsightsCompanion toCompanion(bool nullToAbsent) {
    return BehavioralInsightsCompanion(
      id: Value(id),
      insightType: Value(insightType),
      title: Value(title),
      message: Value(message),
      severity: Value(severity),
      timestamp: Value(timestamp),
      isDismissed: Value(isDismissed),
    );
  }

  factory BehavioralInsight.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BehavioralInsight(
      id: serializer.fromJson<String>(json['id']),
      insightType: serializer.fromJson<String>(json['insightType']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      severity: serializer.fromJson<String>(json['severity']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      isDismissed: serializer.fromJson<bool>(json['isDismissed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'insightType': serializer.toJson<String>(insightType),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'severity': serializer.toJson<String>(severity),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'isDismissed': serializer.toJson<bool>(isDismissed),
    };
  }

  BehavioralInsight copyWith(
          {String? id,
          String? insightType,
          String? title,
          String? message,
          String? severity,
          DateTime? timestamp,
          bool? isDismissed}) =>
      BehavioralInsight(
        id: id ?? this.id,
        insightType: insightType ?? this.insightType,
        title: title ?? this.title,
        message: message ?? this.message,
        severity: severity ?? this.severity,
        timestamp: timestamp ?? this.timestamp,
        isDismissed: isDismissed ?? this.isDismissed,
      );
  BehavioralInsight copyWithCompanion(BehavioralInsightsCompanion data) {
    return BehavioralInsight(
      id: data.id.present ? data.id.value : this.id,
      insightType:
          data.insightType.present ? data.insightType.value : this.insightType,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      severity: data.severity.present ? data.severity.value : this.severity,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isDismissed:
          data.isDismissed.present ? data.isDismissed.value : this.isDismissed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BehavioralInsight(')
          ..write('id: $id, ')
          ..write('insightType: $insightType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('severity: $severity, ')
          ..write('timestamp: $timestamp, ')
          ..write('isDismissed: $isDismissed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, insightType, title, message, severity, timestamp, isDismissed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BehavioralInsight &&
          other.id == this.id &&
          other.insightType == this.insightType &&
          other.title == this.title &&
          other.message == this.message &&
          other.severity == this.severity &&
          other.timestamp == this.timestamp &&
          other.isDismissed == this.isDismissed);
}

class BehavioralInsightsCompanion extends UpdateCompanion<BehavioralInsight> {
  final Value<String> id;
  final Value<String> insightType;
  final Value<String> title;
  final Value<String> message;
  final Value<String> severity;
  final Value<DateTime> timestamp;
  final Value<bool> isDismissed;
  final Value<int> rowid;
  const BehavioralInsightsCompanion({
    this.id = const Value.absent(),
    this.insightType = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.severity = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BehavioralInsightsCompanion.insert({
    required String id,
    required String insightType,
    required String title,
    required String message,
    this.severity = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        insightType = Value(insightType),
        title = Value(title),
        message = Value(message);
  static Insertable<BehavioralInsight> custom({
    Expression<String>? id,
    Expression<String>? insightType,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? severity,
    Expression<DateTime>? timestamp,
    Expression<bool>? isDismissed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (insightType != null) 'insight_type': insightType,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (severity != null) 'severity': severity,
      if (timestamp != null) 'timestamp': timestamp,
      if (isDismissed != null) 'is_dismissed': isDismissed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BehavioralInsightsCompanion copyWith(
      {Value<String>? id,
      Value<String>? insightType,
      Value<String>? title,
      Value<String>? message,
      Value<String>? severity,
      Value<DateTime>? timestamp,
      Value<bool>? isDismissed,
      Value<int>? rowid}) {
    return BehavioralInsightsCompanion(
      id: id ?? this.id,
      insightType: insightType ?? this.insightType,
      title: title ?? this.title,
      message: message ?? this.message,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      isDismissed: isDismissed ?? this.isDismissed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (insightType.present) {
      map['insight_type'] = Variable<String>(insightType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (isDismissed.present) {
      map['is_dismissed'] = Variable<bool>(isDismissed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BehavioralInsightsCompanion(')
          ..write('id: $id, ')
          ..write('insightType: $insightType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('severity: $severity, ')
          ..write('timestamp: $timestamp, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $LifeAreasTable lifeAreas = $LifeAreasTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $MilestonesTable milestones = $MilestonesTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $SubtasksTable subtasks = $SubtasksTable(this);
  late final $TaskHistoriesTable taskHistories = $TaskHistoriesTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitOccurrencesTable habitOccurrences =
      $HabitOccurrencesTable(this);
  late final $CalendarEventsTable calendarEvents = $CalendarEventsTable(this);
  late final $TimeBlocksTable timeBlocks = $TimeBlocksTable(this);
  late final $FocusSessionsTable focusSessions = $FocusSessionsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $NoteBlocksTable noteBlocks = $NoteBlocksTable(this);
  late final $DailyReviewsTable dailyReviews = $DailyReviewsTable(this);
  late final $WeeklyReviewsTable weeklyReviews = $WeeklyReviewsTable(this);
  late final $BehavioralInsightsTable behavioralInsights =
      $BehavioralInsightsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userProfiles,
        lifeAreas,
        goals,
        milestones,
        projects,
        tasks,
        subtasks,
        taskHistories,
        habits,
        habitOccurrences,
        calendarEvents,
        timeBlocks,
        focusSessions,
        notes,
        noteBlocks,
        dailyReviews,
        weeklyReviews,
        behavioralInsights
      ];
}

typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String id,
  Value<String> name,
  Value<String?> avatarUrl,
  Value<String> energyPreference,
  Value<String> locale,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> avatarUrl,
  Value<String> energyPreference,
  Value<String> locale,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserProfilesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserProfilesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String> energyPreference = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            name: name,
            avatarUrl: avatarUrl,
            energyPreference: energyPreference,
            locale: locale,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String> name = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String> energyPreference = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            name: name,
            avatarUrl: avatarUrl,
            energyPreference: energyPreference,
            locale: locale,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$UserProfilesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get avatarUrl => $state.composableBuilder(
      column: $state.table.avatarUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get energyPreference => $state.composableBuilder(
      column: $state.table.energyPreference,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get locale => $state.composableBuilder(
      column: $state.table.locale,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UserProfilesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get avatarUrl => $state.composableBuilder(
      column: $state.table.avatarUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get energyPreference => $state.composableBuilder(
      column: $state.table.energyPreference,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get locale => $state.composableBuilder(
      column: $state.table.locale,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LifeAreasTableCreateCompanionBuilder = LifeAreasCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<String> icon,
  Value<String> colorHex,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$LifeAreasTableUpdateCompanionBuilder = LifeAreasCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String> icon,
  Value<String> colorHex,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$LifeAreasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LifeAreasTable,
    LifeArea,
    $$LifeAreasTableFilterComposer,
    $$LifeAreasTableOrderingComposer,
    $$LifeAreasTableCreateCompanionBuilder,
    $$LifeAreasTableUpdateCompanionBuilder> {
  $$LifeAreasTableTableManager(_$AppDatabase db, $LifeAreasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LifeAreasTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LifeAreasTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LifeAreasCompanion(
            id: id,
            name: name,
            description: description,
            icon: icon,
            colorHex: colorHex,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LifeAreasCompanion.insert(
            id: id,
            name: name,
            description: description,
            icon: icon,
            colorHex: colorHex,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$LifeAreasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LifeAreasTable> {
  $$LifeAreasTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get icon => $state.composableBuilder(
      column: $state.table.icon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LifeAreasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LifeAreasTable> {
  $$LifeAreasTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get icon => $state.composableBuilder(
      column: $state.table.icon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String?> lifeAreaId,
  Value<String?> visionText,
  Value<DateTime?> targetDate,
  Value<bool> isCompleted,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String?> lifeAreaId,
  Value<String?> visionText,
  Value<DateTime?> targetDate,
  Value<bool> isCompleted,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GoalsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GoalsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<String?> visionText = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            title: title,
            description: description,
            lifeAreaId: lifeAreaId,
            visionText: visionText,
            targetDate: targetDate,
            isCompleted: isCompleted,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<String?> visionText = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            title: title,
            description: description,
            lifeAreaId: lifeAreaId,
            visionText: visionText,
            targetDate: targetDate,
            isCompleted: isCompleted,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$GoalsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get visionText => $state.composableBuilder(
      column: $state.table.visionText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get targetDate => $state.composableBuilder(
      column: $state.table.targetDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$GoalsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get visionText => $state.composableBuilder(
      column: $state.table.visionText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get targetDate => $state.composableBuilder(
      column: $state.table.targetDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MilestonesTableCreateCompanionBuilder = MilestonesCompanion Function({
  required String id,
  required String goalId,
  required String title,
  Value<DateTime?> targetDate,
  Value<bool> isCompleted,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$MilestonesTableUpdateCompanionBuilder = MilestonesCompanion Function({
  Value<String> id,
  Value<String> goalId,
  Value<String> title,
  Value<DateTime?> targetDate,
  Value<bool> isCompleted,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$MilestonesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MilestonesTable,
    Milestone,
    $$MilestonesTableFilterComposer,
    $$MilestonesTableOrderingComposer,
    $$MilestonesTableCreateCompanionBuilder,
    $$MilestonesTableUpdateCompanionBuilder> {
  $$MilestonesTableTableManager(_$AppDatabase db, $MilestonesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MilestonesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MilestonesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> goalId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MilestonesCompanion(
            id: id,
            goalId: goalId,
            title: title,
            targetDate: targetDate,
            isCompleted: isCompleted,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String goalId,
            required String title,
            Value<DateTime?> targetDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MilestonesCompanion.insert(
            id: id,
            goalId: goalId,
            title: title,
            targetDate: targetDate,
            isCompleted: isCompleted,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$MilestonesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get targetDate => $state.composableBuilder(
      column: $state.table.targetDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MilestonesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MilestonesTable> {
  $$MilestonesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get targetDate => $state.composableBuilder(
      column: $state.table.targetDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String?> goalId,
  Value<String?> lifeAreaId,
  Value<DateTime?> deadline,
  Value<double> progress,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String?> goalId,
  Value<String?> lifeAreaId,
  Value<DateTime?> deadline,
  Value<double> progress,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ProjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder> {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProjectsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProjectsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProjectsCompanion(
            id: id,
            title: title,
            description: description,
            goalId: goalId,
            lifeAreaId: lifeAreaId,
            deadline: deadline,
            progress: progress,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProjectsCompanion.insert(
            id: id,
            title: title,
            description: description,
            goalId: goalId,
            lifeAreaId: lifeAreaId,
            deadline: deadline,
            progress: progress,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$ProjectsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deadline => $state.composableBuilder(
      column: $state.table.deadline,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get progress => $state.composableBuilder(
      column: $state.table.progress,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ProjectsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deadline => $state.composableBuilder(
      column: $state.table.deadline,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get progress => $state.composableBuilder(
      column: $state.table.progress,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String> status,
  Value<String> priority,
  Value<int> estimatedDurationMinutes,
  Value<int> actualDurationMinutes,
  Value<DateTime?> scheduledStart,
  Value<DateTime?> scheduledEnd,
  Value<DateTime?> deadline,
  Value<bool> isFlexible,
  Value<bool> isCommitment,
  Value<int> energyLevel,
  Value<int> difficulty,
  Value<String?> projectId,
  Value<String?> goalId,
  Value<String?> lifeAreaId,
  Value<String?> parentTaskId,
  Value<String?> recurrenceRule,
  Value<int> postponementCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String> status,
  Value<String> priority,
  Value<int> estimatedDurationMinutes,
  Value<int> actualDurationMinutes,
  Value<DateTime?> scheduledStart,
  Value<DateTime?> scheduledEnd,
  Value<DateTime?> deadline,
  Value<bool> isFlexible,
  Value<bool> isCommitment,
  Value<int> energyLevel,
  Value<int> difficulty,
  Value<String?> projectId,
  Value<String?> goalId,
  Value<String?> lifeAreaId,
  Value<String?> parentTaskId,
  Value<String?> recurrenceRule,
  Value<int> postponementCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TasksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TasksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<int> estimatedDurationMinutes = const Value.absent(),
            Value<int> actualDurationMinutes = const Value.absent(),
            Value<DateTime?> scheduledStart = const Value.absent(),
            Value<DateTime?> scheduledEnd = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<bool> isFlexible = const Value.absent(),
            Value<bool> isCommitment = const Value.absent(),
            Value<int> energyLevel = const Value.absent(),
            Value<int> difficulty = const Value.absent(),
            Value<String?> projectId = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<String?> parentTaskId = const Value.absent(),
            Value<String?> recurrenceRule = const Value.absent(),
            Value<int> postponementCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            description: description,
            status: status,
            priority: priority,
            estimatedDurationMinutes: estimatedDurationMinutes,
            actualDurationMinutes: actualDurationMinutes,
            scheduledStart: scheduledStart,
            scheduledEnd: scheduledEnd,
            deadline: deadline,
            isFlexible: isFlexible,
            isCommitment: isCommitment,
            energyLevel: energyLevel,
            difficulty: difficulty,
            projectId: projectId,
            goalId: goalId,
            lifeAreaId: lifeAreaId,
            parentTaskId: parentTaskId,
            recurrenceRule: recurrenceRule,
            postponementCount: postponementCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<int> estimatedDurationMinutes = const Value.absent(),
            Value<int> actualDurationMinutes = const Value.absent(),
            Value<DateTime?> scheduledStart = const Value.absent(),
            Value<DateTime?> scheduledEnd = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<bool> isFlexible = const Value.absent(),
            Value<bool> isCommitment = const Value.absent(),
            Value<int> energyLevel = const Value.absent(),
            Value<int> difficulty = const Value.absent(),
            Value<String?> projectId = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<String?> parentTaskId = const Value.absent(),
            Value<String?> recurrenceRule = const Value.absent(),
            Value<int> postponementCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            description: description,
            status: status,
            priority: priority,
            estimatedDurationMinutes: estimatedDurationMinutes,
            actualDurationMinutes: actualDurationMinutes,
            scheduledStart: scheduledStart,
            scheduledEnd: scheduledEnd,
            deadline: deadline,
            isFlexible: isFlexible,
            isCommitment: isCommitment,
            energyLevel: energyLevel,
            difficulty: difficulty,
            projectId: projectId,
            goalId: goalId,
            lifeAreaId: lifeAreaId,
            parentTaskId: parentTaskId,
            recurrenceRule: recurrenceRule,
            postponementCount: postponementCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
        ));
}

class $$TasksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get estimatedDurationMinutes => $state.composableBuilder(
      column: $state.table.estimatedDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get actualDurationMinutes => $state.composableBuilder(
      column: $state.table.actualDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get scheduledStart => $state.composableBuilder(
      column: $state.table.scheduledStart,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get scheduledEnd => $state.composableBuilder(
      column: $state.table.scheduledEnd,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deadline => $state.composableBuilder(
      column: $state.table.deadline,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFlexible => $state.composableBuilder(
      column: $state.table.isFlexible,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCommitment => $state.composableBuilder(
      column: $state.table.isCommitment,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get energyLevel => $state.composableBuilder(
      column: $state.table.energyLevel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get difficulty => $state.composableBuilder(
      column: $state.table.difficulty,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get projectId => $state.composableBuilder(
      column: $state.table.projectId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get parentTaskId => $state.composableBuilder(
      column: $state.table.parentTaskId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get recurrenceRule => $state.composableBuilder(
      column: $state.table.recurrenceRule,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get postponementCount => $state.composableBuilder(
      column: $state.table.postponementCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TasksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get estimatedDurationMinutes => $state.composableBuilder(
      column: $state.table.estimatedDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get actualDurationMinutes => $state.composableBuilder(
      column: $state.table.actualDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get scheduledStart => $state.composableBuilder(
      column: $state.table.scheduledStart,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get scheduledEnd => $state.composableBuilder(
      column: $state.table.scheduledEnd,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deadline => $state.composableBuilder(
      column: $state.table.deadline,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFlexible => $state.composableBuilder(
      column: $state.table.isFlexible,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCommitment => $state.composableBuilder(
      column: $state.table.isCommitment,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get energyLevel => $state.composableBuilder(
      column: $state.table.energyLevel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get difficulty => $state.composableBuilder(
      column: $state.table.difficulty,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get projectId => $state.composableBuilder(
      column: $state.table.projectId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get parentTaskId => $state.composableBuilder(
      column: $state.table.parentTaskId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get recurrenceRule => $state.composableBuilder(
      column: $state.table.recurrenceRule,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get postponementCount => $state.composableBuilder(
      column: $state.table.postponementCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SubtasksTableCreateCompanionBuilder = SubtasksCompanion Function({
  required String id,
  required String taskId,
  required String title,
  Value<bool> isCompleted,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$SubtasksTableUpdateCompanionBuilder = SubtasksCompanion Function({
  Value<String> id,
  Value<String> taskId,
  Value<String> title,
  Value<bool> isCompleted,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$SubtasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubtasksTable,
    Subtask,
    $$SubtasksTableFilterComposer,
    $$SubtasksTableOrderingComposer,
    $$SubtasksTableCreateCompanionBuilder,
    $$SubtasksTableUpdateCompanionBuilder> {
  $$SubtasksTableTableManager(_$AppDatabase db, $SubtasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SubtasksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SubtasksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubtasksCompanion(
            id: id,
            taskId: taskId,
            title: title,
            isCompleted: isCompleted,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required String title,
            Value<bool> isCompleted = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubtasksCompanion.insert(
            id: id,
            taskId: taskId,
            title: title,
            isCompleted: isCompleted,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$SubtasksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SubtasksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TaskHistoriesTableCreateCompanionBuilder = TaskHistoriesCompanion
    Function({
  required String id,
  required String taskId,
  required String actionType,
  Value<DateTime> timestamp,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$TaskHistoriesTableUpdateCompanionBuilder = TaskHistoriesCompanion
    Function({
  Value<String> id,
  Value<String> taskId,
  Value<String> actionType,
  Value<DateTime> timestamp,
  Value<String?> notes,
  Value<int> rowid,
});

class $$TaskHistoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskHistoriesTable,
    TaskHistory,
    $$TaskHistoriesTableFilterComposer,
    $$TaskHistoriesTableOrderingComposer,
    $$TaskHistoriesTableCreateCompanionBuilder,
    $$TaskHistoriesTableUpdateCompanionBuilder> {
  $$TaskHistoriesTableTableManager(_$AppDatabase db, $TaskHistoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TaskHistoriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TaskHistoriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<String> actionType = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskHistoriesCompanion(
            id: id,
            taskId: taskId,
            actionType: actionType,
            timestamp: timestamp,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required String actionType,
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskHistoriesCompanion.insert(
            id: id,
            taskId: taskId,
            actionType: actionType,
            timestamp: timestamp,
            notes: notes,
            rowid: rowid,
          ),
        ));
}

class $$TaskHistoriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TaskHistoriesTable> {
  $$TaskHistoriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get actionType => $state.composableBuilder(
      column: $state.table.actionType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TaskHistoriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TaskHistoriesTable> {
  $$TaskHistoriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get actionType => $state.composableBuilder(
      column: $state.table.actionType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String?> lifeAreaId,
  Value<String> frequencyType,
  Value<int> targetDaysOfWeekMask,
  Value<int> targetCountPerPeriod,
  Value<String> colorHex,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String?> lifeAreaId,
  Value<String> frequencyType,
  Value<int> targetDaysOfWeekMask,
  Value<int> targetCountPerPeriod,
  Value<String> colorHex,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$HabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HabitsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HabitsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<String> frequencyType = const Value.absent(),
            Value<int> targetDaysOfWeekMask = const Value.absent(),
            Value<int> targetCountPerPeriod = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            title: title,
            description: description,
            lifeAreaId: lifeAreaId,
            frequencyType: frequencyType,
            targetDaysOfWeekMask: targetDaysOfWeekMask,
            targetCountPerPeriod: targetCountPerPeriod,
            colorHex: colorHex,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> lifeAreaId = const Value.absent(),
            Value<String> frequencyType = const Value.absent(),
            Value<int> targetDaysOfWeekMask = const Value.absent(),
            Value<int> targetCountPerPeriod = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            title: title,
            description: description,
            lifeAreaId: lifeAreaId,
            frequencyType: frequencyType,
            targetDaysOfWeekMask: targetDaysOfWeekMask,
            targetCountPerPeriod: targetCountPerPeriod,
            colorHex: colorHex,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$HabitsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get frequencyType => $state.composableBuilder(
      column: $state.table.frequencyType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get targetDaysOfWeekMask => $state.composableBuilder(
      column: $state.table.targetDaysOfWeekMask,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get targetCountPerPeriod => $state.composableBuilder(
      column: $state.table.targetCountPerPeriod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HabitsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lifeAreaId => $state.composableBuilder(
      column: $state.table.lifeAreaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get frequencyType => $state.composableBuilder(
      column: $state.table.frequencyType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get targetDaysOfWeekMask => $state.composableBuilder(
      column: $state.table.targetDaysOfWeekMask,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get targetCountPerPeriod => $state.composableBuilder(
      column: $state.table.targetCountPerPeriod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$HabitOccurrencesTableCreateCompanionBuilder
    = HabitOccurrencesCompanion Function({
  required String id,
  required String habitId,
  required DateTime date,
  Value<bool> isCompleted,
  Value<int> valueCount,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$HabitOccurrencesTableUpdateCompanionBuilder
    = HabitOccurrencesCompanion Function({
  Value<String> id,
  Value<String> habitId,
  Value<DateTime> date,
  Value<bool> isCompleted,
  Value<int> valueCount,
  Value<String?> notes,
  Value<int> rowid,
});

class $$HabitOccurrencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitOccurrencesTable,
    HabitOccurrence,
    $$HabitOccurrencesTableFilterComposer,
    $$HabitOccurrencesTableOrderingComposer,
    $$HabitOccurrencesTableCreateCompanionBuilder,
    $$HabitOccurrencesTableUpdateCompanionBuilder> {
  $$HabitOccurrencesTableTableManager(
      _$AppDatabase db, $HabitOccurrencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HabitOccurrencesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HabitOccurrencesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> habitId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> valueCount = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitOccurrencesCompanion(
            id: id,
            habitId: habitId,
            date: date,
            isCompleted: isCompleted,
            valueCount: valueCount,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String habitId,
            required DateTime date,
            Value<bool> isCompleted = const Value.absent(),
            Value<int> valueCount = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitOccurrencesCompanion.insert(
            id: id,
            habitId: habitId,
            date: date,
            isCompleted: isCompleted,
            valueCount: valueCount,
            notes: notes,
            rowid: rowid,
          ),
        ));
}

class $$HabitOccurrencesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $HabitOccurrencesTable> {
  $$HabitOccurrencesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get habitId => $state.composableBuilder(
      column: $state.table.habitId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get valueCount => $state.composableBuilder(
      column: $state.table.valueCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HabitOccurrencesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $HabitOccurrencesTable> {
  $$HabitOccurrencesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get habitId => $state.composableBuilder(
      column: $state.table.habitId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get valueCount => $state.composableBuilder(
      column: $state.table.valueCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CalendarEventsTableCreateCompanionBuilder = CalendarEventsCompanion
    Function({
  required String id,
  required String title,
  Value<String?> description,
  required DateTime startTime,
  required DateTime endTime,
  Value<bool> isAllDay,
  Value<String> colorHex,
  Value<int> rowid,
});
typedef $$CalendarEventsTableUpdateCompanionBuilder = CalendarEventsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<bool> isAllDay,
  Value<String> colorHex,
  Value<int> rowid,
});

class $$CalendarEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CalendarEventsTable,
    CalendarEvent,
    $$CalendarEventsTableFilterComposer,
    $$CalendarEventsTableOrderingComposer,
    $$CalendarEventsTableCreateCompanionBuilder,
    $$CalendarEventsTableUpdateCompanionBuilder> {
  $$CalendarEventsTableTableManager(
      _$AppDatabase db, $CalendarEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CalendarEventsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CalendarEventsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<bool> isAllDay = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CalendarEventsCompanion(
            id: id,
            title: title,
            description: description,
            startTime: startTime,
            endTime: endTime,
            isAllDay: isAllDay,
            colorHex: colorHex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            required DateTime startTime,
            required DateTime endTime,
            Value<bool> isAllDay = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CalendarEventsCompanion.insert(
            id: id,
            title: title,
            description: description,
            startTime: startTime,
            endTime: endTime,
            isAllDay: isAllDay,
            colorHex: colorHex,
            rowid: rowid,
          ),
        ));
}

class $$CalendarEventsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isAllDay => $state.composableBuilder(
      column: $state.table.isAllDay,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CalendarEventsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isAllDay => $state.composableBuilder(
      column: $state.table.isAllDay,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TimeBlocksTableCreateCompanionBuilder = TimeBlocksCompanion Function({
  required String id,
  Value<String?> taskId,
  required String title,
  required DateTime startTime,
  required DateTime endTime,
  Value<String> source,
  Value<String> status,
  Value<int> rowid,
});
typedef $$TimeBlocksTableUpdateCompanionBuilder = TimeBlocksCompanion Function({
  Value<String> id,
  Value<String?> taskId,
  Value<String> title,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<String> source,
  Value<String> status,
  Value<int> rowid,
});

class $$TimeBlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimeBlocksTable,
    TimeBlock,
    $$TimeBlocksTableFilterComposer,
    $$TimeBlocksTableOrderingComposer,
    $$TimeBlocksTableCreateCompanionBuilder,
    $$TimeBlocksTableUpdateCompanionBuilder> {
  $$TimeBlocksTableTableManager(_$AppDatabase db, $TimeBlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TimeBlocksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TimeBlocksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> taskId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeBlocksCompanion(
            id: id,
            taskId: taskId,
            title: title,
            startTime: startTime,
            endTime: endTime,
            source: source,
            status: status,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> taskId = const Value.absent(),
            required String title,
            required DateTime startTime,
            required DateTime endTime,
            Value<String> source = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeBlocksCompanion.insert(
            id: id,
            taskId: taskId,
            title: title,
            startTime: startTime,
            endTime: endTime,
            source: source,
            status: status,
            rowid: rowid,
          ),
        ));
}

class $$TimeBlocksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TimeBlocksTable> {
  $$TimeBlocksTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get source => $state.composableBuilder(
      column: $state.table.source,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TimeBlocksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TimeBlocksTable> {
  $$TimeBlocksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get source => $state.composableBuilder(
      column: $state.table.source,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$FocusSessionsTableCreateCompanionBuilder = FocusSessionsCompanion
    Function({
  required String id,
  Value<String?> taskId,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  required int plannedDurationMinutes,
  Value<int> actualDurationMinutes,
  Value<int> interruptedCount,
  Value<bool> isCompleted,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$FocusSessionsTableUpdateCompanionBuilder = FocusSessionsCompanion
    Function({
  Value<String> id,
  Value<String?> taskId,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<int> plannedDurationMinutes,
  Value<int> actualDurationMinutes,
  Value<int> interruptedCount,
  Value<bool> isCompleted,
  Value<String?> notes,
  Value<int> rowid,
});

class $$FocusSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusSessionsTable,
    FocusSession,
    $$FocusSessionsTableFilterComposer,
    $$FocusSessionsTableOrderingComposer,
    $$FocusSessionsTableCreateCompanionBuilder,
    $$FocusSessionsTableUpdateCompanionBuilder> {
  $$FocusSessionsTableTableManager(_$AppDatabase db, $FocusSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FocusSessionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FocusSessionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> taskId = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> endedAt = const Value.absent(),
            Value<int> plannedDurationMinutes = const Value.absent(),
            Value<int> actualDurationMinutes = const Value.absent(),
            Value<int> interruptedCount = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FocusSessionsCompanion(
            id: id,
            taskId: taskId,
            startedAt: startedAt,
            endedAt: endedAt,
            plannedDurationMinutes: plannedDurationMinutes,
            actualDurationMinutes: actualDurationMinutes,
            interruptedCount: interruptedCount,
            isCompleted: isCompleted,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> taskId = const Value.absent(),
            required DateTime startedAt,
            Value<DateTime?> endedAt = const Value.absent(),
            required int plannedDurationMinutes,
            Value<int> actualDurationMinutes = const Value.absent(),
            Value<int> interruptedCount = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FocusSessionsCompanion.insert(
            id: id,
            taskId: taskId,
            startedAt: startedAt,
            endedAt: endedAt,
            plannedDurationMinutes: plannedDurationMinutes,
            actualDurationMinutes: actualDurationMinutes,
            interruptedCount: interruptedCount,
            isCompleted: isCompleted,
            notes: notes,
            rowid: rowid,
          ),
        ));
}

class $$FocusSessionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endedAt => $state.composableBuilder(
      column: $state.table.endedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get plannedDurationMinutes => $state.composableBuilder(
      column: $state.table.plannedDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get actualDurationMinutes => $state.composableBuilder(
      column: $state.table.actualDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get interruptedCount => $state.composableBuilder(
      column: $state.table.interruptedCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FocusSessionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get taskId => $state.composableBuilder(
      column: $state.table.taskId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endedAt => $state.composableBuilder(
      column: $state.table.endedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get plannedDurationMinutes => $state.composableBuilder(
      column: $state.table.plannedDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get actualDurationMinutes => $state.composableBuilder(
      column: $state.table.actualDurationMinutes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get interruptedCount => $state.composableBuilder(
      column: $state.table.interruptedCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  required String id,
  required String title,
  Value<String> folderName,
  Value<String?> projectId,
  Value<String?> goalId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> folderName,
  Value<String?> projectId,
  Value<String?> goalId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$NotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder> {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NotesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NotesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> folderName = const Value.absent(),
            Value<String?> projectId = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            title: title,
            folderName: folderName,
            projectId: projectId,
            goalId: goalId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String> folderName = const Value.absent(),
            Value<String?> projectId = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            id: id,
            title: title,
            folderName: folderName,
            projectId: projectId,
            goalId: goalId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$NotesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get folderName => $state.composableBuilder(
      column: $state.table.folderName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get projectId => $state.composableBuilder(
      column: $state.table.projectId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NotesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get folderName => $state.composableBuilder(
      column: $state.table.folderName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get projectId => $state.composableBuilder(
      column: $state.table.projectId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get goalId => $state.composableBuilder(
      column: $state.table.goalId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NoteBlocksTableCreateCompanionBuilder = NoteBlocksCompanion Function({
  required String id,
  required String noteId,
  Value<String> blockType,
  required String content,
  Value<bool> isChecked,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$NoteBlocksTableUpdateCompanionBuilder = NoteBlocksCompanion Function({
  Value<String> id,
  Value<String> noteId,
  Value<String> blockType,
  Value<String> content,
  Value<bool> isChecked,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$NoteBlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NoteBlocksTable,
    NoteBlock,
    $$NoteBlocksTableFilterComposer,
    $$NoteBlocksTableOrderingComposer,
    $$NoteBlocksTableCreateCompanionBuilder,
    $$NoteBlocksTableUpdateCompanionBuilder> {
  $$NoteBlocksTableTableManager(_$AppDatabase db, $NoteBlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NoteBlocksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NoteBlocksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> noteId = const Value.absent(),
            Value<String> blockType = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<bool> isChecked = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteBlocksCompanion(
            id: id,
            noteId: noteId,
            blockType: blockType,
            content: content,
            isChecked: isChecked,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String noteId,
            Value<String> blockType = const Value.absent(),
            required String content,
            Value<bool> isChecked = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteBlocksCompanion.insert(
            id: id,
            noteId: noteId,
            blockType: blockType,
            content: content,
            isChecked: isChecked,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$NoteBlocksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NoteBlocksTable> {
  $$NoteBlocksTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get noteId => $state.composableBuilder(
      column: $state.table.noteId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get blockType => $state.composableBuilder(
      column: $state.table.blockType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isChecked => $state.composableBuilder(
      column: $state.table.isChecked,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NoteBlocksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NoteBlocksTable> {
  $$NoteBlocksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get noteId => $state.composableBuilder(
      column: $state.table.noteId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get blockType => $state.composableBuilder(
      column: $state.table.blockType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isChecked => $state.composableBuilder(
      column: $state.table.isChecked,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DailyReviewsTableCreateCompanionBuilder = DailyReviewsCompanion
    Function({
  required String id,
  required DateTime date,
  Value<int> energyRating,
  Value<int> focusRating,
  Value<String?> obstaclesText,
  Value<String?> reflectionText,
  Value<String?> tomorrowPrioritiesJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DailyReviewsTableUpdateCompanionBuilder = DailyReviewsCompanion
    Function({
  Value<String> id,
  Value<DateTime> date,
  Value<int> energyRating,
  Value<int> focusRating,
  Value<String?> obstaclesText,
  Value<String?> reflectionText,
  Value<String?> tomorrowPrioritiesJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DailyReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyReviewsTable,
    DailyReview,
    $$DailyReviewsTableFilterComposer,
    $$DailyReviewsTableOrderingComposer,
    $$DailyReviewsTableCreateCompanionBuilder,
    $$DailyReviewsTableUpdateCompanionBuilder> {
  $$DailyReviewsTableTableManager(_$AppDatabase db, $DailyReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DailyReviewsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DailyReviewsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> energyRating = const Value.absent(),
            Value<int> focusRating = const Value.absent(),
            Value<String?> obstaclesText = const Value.absent(),
            Value<String?> reflectionText = const Value.absent(),
            Value<String?> tomorrowPrioritiesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyReviewsCompanion(
            id: id,
            date: date,
            energyRating: energyRating,
            focusRating: focusRating,
            obstaclesText: obstaclesText,
            reflectionText: reflectionText,
            tomorrowPrioritiesJson: tomorrowPrioritiesJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            Value<int> energyRating = const Value.absent(),
            Value<int> focusRating = const Value.absent(),
            Value<String?> obstaclesText = const Value.absent(),
            Value<String?> reflectionText = const Value.absent(),
            Value<String?> tomorrowPrioritiesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyReviewsCompanion.insert(
            id: id,
            date: date,
            energyRating: energyRating,
            focusRating: focusRating,
            obstaclesText: obstaclesText,
            reflectionText: reflectionText,
            tomorrowPrioritiesJson: tomorrowPrioritiesJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$DailyReviewsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DailyReviewsTable> {
  $$DailyReviewsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get energyRating => $state.composableBuilder(
      column: $state.table.energyRating,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get focusRating => $state.composableBuilder(
      column: $state.table.focusRating,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get obstaclesText => $state.composableBuilder(
      column: $state.table.obstaclesText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reflectionText => $state.composableBuilder(
      column: $state.table.reflectionText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tomorrowPrioritiesJson => $state.composableBuilder(
      column: $state.table.tomorrowPrioritiesJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DailyReviewsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DailyReviewsTable> {
  $$DailyReviewsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get energyRating => $state.composableBuilder(
      column: $state.table.energyRating,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get focusRating => $state.composableBuilder(
      column: $state.table.focusRating,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get obstaclesText => $state.composableBuilder(
      column: $state.table.obstaclesText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reflectionText => $state.composableBuilder(
      column: $state.table.reflectionText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tomorrowPrioritiesJson =>
      $state.composableBuilder(
          column: $state.table.tomorrowPrioritiesJson,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WeeklyReviewsTableCreateCompanionBuilder = WeeklyReviewsCompanion
    Function({
  required String id,
  required DateTime startDate,
  required DateTime endDate,
  Value<String?> reflectionText,
  Value<String?> strategicAdjustmentsText,
  Value<double> completionRate,
  Value<double> commitmentReliabilityRate,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$WeeklyReviewsTableUpdateCompanionBuilder = WeeklyReviewsCompanion
    Function({
  Value<String> id,
  Value<DateTime> startDate,
  Value<DateTime> endDate,
  Value<String?> reflectionText,
  Value<String?> strategicAdjustmentsText,
  Value<double> completionRate,
  Value<double> commitmentReliabilityRate,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$WeeklyReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeeklyReviewsTable,
    WeeklyReview,
    $$WeeklyReviewsTableFilterComposer,
    $$WeeklyReviewsTableOrderingComposer,
    $$WeeklyReviewsTableCreateCompanionBuilder,
    $$WeeklyReviewsTableUpdateCompanionBuilder> {
  $$WeeklyReviewsTableTableManager(_$AppDatabase db, $WeeklyReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WeeklyReviewsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WeeklyReviewsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime> endDate = const Value.absent(),
            Value<String?> reflectionText = const Value.absent(),
            Value<String?> strategicAdjustmentsText = const Value.absent(),
            Value<double> completionRate = const Value.absent(),
            Value<double> commitmentReliabilityRate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyReviewsCompanion(
            id: id,
            startDate: startDate,
            endDate: endDate,
            reflectionText: reflectionText,
            strategicAdjustmentsText: strategicAdjustmentsText,
            completionRate: completionRate,
            commitmentReliabilityRate: commitmentReliabilityRate,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime startDate,
            required DateTime endDate,
            Value<String?> reflectionText = const Value.absent(),
            Value<String?> strategicAdjustmentsText = const Value.absent(),
            Value<double> completionRate = const Value.absent(),
            Value<double> commitmentReliabilityRate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyReviewsCompanion.insert(
            id: id,
            startDate: startDate,
            endDate: endDate,
            reflectionText: reflectionText,
            strategicAdjustmentsText: strategicAdjustmentsText,
            completionRate: completionRate,
            commitmentReliabilityRate: commitmentReliabilityRate,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$WeeklyReviewsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startDate => $state.composableBuilder(
      column: $state.table.startDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endDate => $state.composableBuilder(
      column: $state.table.endDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reflectionText => $state.composableBuilder(
      column: $state.table.reflectionText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get strategicAdjustmentsText =>
      $state.composableBuilder(
          column: $state.table.strategicAdjustmentsText,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get completionRate => $state.composableBuilder(
      column: $state.table.completionRate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get commitmentReliabilityRate =>
      $state.composableBuilder(
          column: $state.table.commitmentReliabilityRate,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WeeklyReviewsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startDate => $state.composableBuilder(
      column: $state.table.startDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endDate => $state.composableBuilder(
      column: $state.table.endDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reflectionText => $state.composableBuilder(
      column: $state.table.reflectionText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get strategicAdjustmentsText =>
      $state.composableBuilder(
          column: $state.table.strategicAdjustmentsText,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get completionRate => $state.composableBuilder(
      column: $state.table.completionRate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get commitmentReliabilityRate => $state
      .composableBuilder(
          column: $state.table.commitmentReliabilityRate,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BehavioralInsightsTableCreateCompanionBuilder
    = BehavioralInsightsCompanion Function({
  required String id,
  required String insightType,
  required String title,
  required String message,
  Value<String> severity,
  Value<DateTime> timestamp,
  Value<bool> isDismissed,
  Value<int> rowid,
});
typedef $$BehavioralInsightsTableUpdateCompanionBuilder
    = BehavioralInsightsCompanion Function({
  Value<String> id,
  Value<String> insightType,
  Value<String> title,
  Value<String> message,
  Value<String> severity,
  Value<DateTime> timestamp,
  Value<bool> isDismissed,
  Value<int> rowid,
});

class $$BehavioralInsightsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BehavioralInsightsTable,
    BehavioralInsight,
    $$BehavioralInsightsTableFilterComposer,
    $$BehavioralInsightsTableOrderingComposer,
    $$BehavioralInsightsTableCreateCompanionBuilder,
    $$BehavioralInsightsTableUpdateCompanionBuilder> {
  $$BehavioralInsightsTableTableManager(
      _$AppDatabase db, $BehavioralInsightsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BehavioralInsightsTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$BehavioralInsightsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> insightType = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String> severity = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<bool> isDismissed = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BehavioralInsightsCompanion(
            id: id,
            insightType: insightType,
            title: title,
            message: message,
            severity: severity,
            timestamp: timestamp,
            isDismissed: isDismissed,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String insightType,
            required String title,
            required String message,
            Value<String> severity = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<bool> isDismissed = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BehavioralInsightsCompanion.insert(
            id: id,
            insightType: insightType,
            title: title,
            message: message,
            severity: severity,
            timestamp: timestamp,
            isDismissed: isDismissed,
            rowid: rowid,
          ),
        ));
}

class $$BehavioralInsightsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BehavioralInsightsTable> {
  $$BehavioralInsightsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get insightType => $state.composableBuilder(
      column: $state.table.insightType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get severity => $state.composableBuilder(
      column: $state.table.severity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDismissed => $state.composableBuilder(
      column: $state.table.isDismissed,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BehavioralInsightsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BehavioralInsightsTable> {
  $$BehavioralInsightsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get insightType => $state.composableBuilder(
      column: $state.table.insightType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get severity => $state.composableBuilder(
      column: $state.table.severity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDismissed => $state.composableBuilder(
      column: $state.table.isDismissed,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$LifeAreasTableTableManager get lifeAreas =>
      $$LifeAreasTableTableManager(_db, _db.lifeAreas);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$MilestonesTableTableManager get milestones =>
      $$MilestonesTableTableManager(_db, _db.milestones);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$SubtasksTableTableManager get subtasks =>
      $$SubtasksTableTableManager(_db, _db.subtasks);
  $$TaskHistoriesTableTableManager get taskHistories =>
      $$TaskHistoriesTableTableManager(_db, _db.taskHistories);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitOccurrencesTableTableManager get habitOccurrences =>
      $$HabitOccurrencesTableTableManager(_db, _db.habitOccurrences);
  $$CalendarEventsTableTableManager get calendarEvents =>
      $$CalendarEventsTableTableManager(_db, _db.calendarEvents);
  $$TimeBlocksTableTableManager get timeBlocks =>
      $$TimeBlocksTableTableManager(_db, _db.timeBlocks);
  $$FocusSessionsTableTableManager get focusSessions =>
      $$FocusSessionsTableTableManager(_db, _db.focusSessions);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$NoteBlocksTableTableManager get noteBlocks =>
      $$NoteBlocksTableTableManager(_db, _db.noteBlocks);
  $$DailyReviewsTableTableManager get dailyReviews =>
      $$DailyReviewsTableTableManager(_db, _db.dailyReviews);
  $$WeeklyReviewsTableTableManager get weeklyReviews =>
      $$WeeklyReviewsTableTableManager(_db, _db.weeklyReviews);
  $$BehavioralInsightsTableTableManager get behavioralInsights =>
      $$BehavioralInsightsTableTableManager(_db, _db.behavioralInsights);
}
