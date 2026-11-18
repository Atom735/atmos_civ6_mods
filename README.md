# atmos_civ6_mods

Моды для Civilization VI (macOS / Steam).

## Atmos: Human Start Boost

Папка: [`atmos_human_start_boost`](atmos_human_start_boost/)

Единая настраиваемая замена модов:

| Старый мод | Чем заменяется |
|---|---|
| Extra Starting Settler (Human Players Only) | слайдер «Доп. поселенцы на старте» |
| Sight Enhance | слайдер «Бонус обзора» |
| Move +2 (Human Only) | слайдер «Бонус передвижения» |
| Player's first settler grants +N movement/+N Sight | те же слайдеры, но на **все** юниты человека |

**Важно:** отключи/удали старые моды, иначе бонусы сложатся.

Стартовые юниты учитывают уникальные замены цивилизации (например, у **Кри** вместо разведчика выдаётся **Окихчито**).

### Дефолты

- обзор **+2**
- передвижение **+2**
- поселенец **+1**, строитель **+1**, разведчик **+2**, воин **+0**

Настройки — в **Create Game → Advanced Setup**.

Локаль названия/описания мода: `en_US`, `ru_RU`, `zh_Hans_CN`, `zh_Hant_HK` (через `<LocalizedText>` в `.modinfo`).

### Установка в игру (macOS Steam)

```bash
./scripts/install_human_start_boost.sh
```

Или вручную скопируй `atmos_human_start_boost` в:

`~/Library/Application Support/Sid Meier's Civilization VI/Sid Meier's Civilization VI/Mods/`

Затем: Additional Content → Mods → включи **Atmos: Human Start Boost**.

### Публикация в Steam Workshop (steamcmd)

Айтем: https://steamcommunity.com/sharedfiles/filedetails/?id=3842173946

1. Установить SteamCMD:

```bash
./scripts/install_steamcmd.sh
```

2. Залить **контент** (без preview — у Civ 6 steamcmd часто падает на превью с `Access Denied` / LegacyCloud):

```bash
./.steamcmd/steamcmd.sh +login atom735_2012 +workshop_build_item "/Users/atom735/gits/atmos_civ6_mods/workshop/upload_content_only.vdf" +quit
```

3. Превью поставь вручную на странице Workshop → **Add/Edit images** (файл `workshop/preview_small.jpg` или `preview.jpg`).

4. Проверь мод, затем смени visibility на **Public**.

`workshop/upload.vdf` с `previewfile` можно пробовать позже; если снова `Access Denied` на preview — это ограничение Steam/игры, не мода.
