=begin
===============================================================================
  持有装备作为事件出现条件 By喵呜喵5
===============================================================================

【说明】

  事件出现条件只支持持有物品而不支持持有装备，
  这个脚本允许你将持有指定装备作为事件的出现条件  
  
  例如，在设定部分将一号物品设定为1号武器，
  之后运行游戏的时候，出现条件为“持有1号物品”的事件将只在持有1号武器时出现
  
  这个脚本同样也将影响条件分歧中判定是否拥有对应物品的处理
  
=end
$m5script ||= {};$m5script["M5EI20140909"] = 20140909
module M5EI20140909  
  WEAPONS = {
#==============================================================================
# 设定部分
#==============================================================================


  1 => [1],
  
  2 => [2,true],
  
  # 设置武器对应的出现条件，格式为：
  #   物品的ID => [武器的ID , 是否包含已经装备在角色身上的武器],
  # (不要忘记最后的英文逗号)
  # 若要包含已装备的武器则第二项填写true，否则填写false或者留空
  
#==============================================================================
  };ARMORS = { # 请不要修改本行
#==============================================================================


  3 => [1,false],
  
  # 设置武器对应的出现条件，格式为：
  #   物品的ID => [防具的ID , 是否包含已经装备在角色身上的防具],
  # (不要忘记最后的英文逗号)
  # 若要包含已装备的防具则第二项填写true，否则填写false或者留空
  
#==============================================================================
# 设定结束
#==============================================================================   }  
end
class Game_Party < Game_Unit
  alias m5_20140909_has_item? has_item?
  def has_item?(item, include_equip = false)    
    return m5_20140909_has_item?(item,include_equip) if item.class != RPG::Item
    if set_array = M5EI20140909::WEAPONS[item.id]
      return m5_20140909_has_item?($data_weapons[set_array[0]],set_array[1])
    end
    if set_array = M5EI20140909::ARMORS[item.id]
      return m5_20140909_has_item?($data_armors[set_array[0]],set_array[1])
    end
    return m5_20140909_has_item?(item,include_equip)
  end
end
