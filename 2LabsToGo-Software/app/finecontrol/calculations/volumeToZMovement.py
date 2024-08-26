def volume_to_z_movement(volume, ul, syringe_type_length, syringe_type_volume):
    """
    if ul -> true:
    volume in ul -> zMovement in (mm)
    else:
    volume in ml -> zMovement in (mm)
    """
    
    if ul:
        return round(syringe_type_length * float(volume) / (syringe_type_volume * 1000), 2)
    else:
        return round(syringe_type_length * float(volume) / syringe_type_volume, 2)
