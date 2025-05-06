-- سكريبت كشف الأكواد مع ثلاث واجهات متتابعة

-- الواجهة الأولى
function screen1()
    local input = gg.prompt(
        {
            '[مجاني] 👑 حروف الموت 👑 تلو علي\nاكتب اسم الاوفست', 
            'ادخل رقمك !!'
        }, 
        {
            ['[مجاني] 👑 حروف الموت 👑 تلو علي\nاكتب اسم الاوفست']='', 
            ['ادخل رقمك !!']='0'
        }, 
        {
            'text', 
            'number'
        }
    )
    
    if not input then 
        gg.alert('خروج 😔') 
        os.exit() 
    end
    
    return input
end

-- الواجهة الثانية
function screen2(offsetName, number)
    local options = gg.prompt(
        {
            'اسم الطريقة =', 
            'اسم الفئة =', 
            'كشف كود ☑', 
            'تفعيل 💡'
        }, 
        {
            ['اسم الطريقة =']='get_Coins', 
            ['اسم الفئة =']='nil', 
            ['كشف كود ☑']=true, 
            ['تفعيل 💡']=false
        }, 
        {
            'text', 
            'text', 
            'checkbox', 
            'checkbox'
        }
    )
    
    if not options then 
        gg.alert('خروج 😔') 
        os.exit() 
    end
    
    -- ضمان عدم وجود قيم nil
    options['اسم الطريقة ='] = options['اسم الطريقة ='] or ''
    options['اسم الفئة ='] = options['اسم الفئة ='] or 'nil'
    
    return options
end




function screen3()
    local foundOffset = "0x12345678" -- تأكد أن الأوفست صحيح
    
    local choice = gg.choice({
        "📋 نسخ الأوفست"
    }, nil, "⚙️ النتائج ⚙️\n\n🎯 الأوفست: " .. foundOffset)

    if choice == 1 then
        -- محاولة النسخ بـ gg.copyText أولاً
        if gg.copyText then
            gg.copyText(foundOffset)
            gg.toast("✓ تم النسخ: " .. foundOffset)
        else
            -- إذا فشل، استخدم طريقة بديلة
            gg.alert("❌ الخطأ: لا يدعم GG النسخ التلقائي\n\n" .. foundOffset, "موافق")
            print("انسخ هذا الأوفست يدوياً: " .. foundOffset)
        end
    end
end

-- التنفيذ الرئيسي
gg.toast("أهلاً بك في أداة كشف الأكواد 🛠️")

-- الانتقال بين الواجهات
local inputs1 = screen1()
local options2 = screen2(
    inputs1['[مجاني] 👑 حروف الموت 👑 تلو علي\nاكتب اسم الاوفست'], 
    inputs1['ادخل رقمك !!']
)

screen3(
    inputs1['[مجاني] 👑 حروف الموت 👑 تلو علي\nاكتب اسم الاوفست'], 
    inputs1['ادخل رقمك !!'],
    options2['اسم الطريقة ='], 
    options2['اسم الفئة ='], 
    options2['كشف كود ☑'], 
    options2['تفعيل 💡']
)