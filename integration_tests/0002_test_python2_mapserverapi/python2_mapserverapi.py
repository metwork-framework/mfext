import os
import mapserverapi


qs = "LAYERS=ocean&TRANSPARENT=true&FORMAT=image%2Fpng&SERVICE=WMS&" \
    "VERSION=1.1.1&REQUEST=GetMap&STYLES=&EXCEPTIONS=application%2Fvnd.ogc." \
    "se_xml&SRS=EPSG%3A4326&BBOX=-180.0,-90.0,180.0,90.0&WIDTH=500&HEIGHT=250"
datadir = os.path.realpath(os.path.dirname(os.path.realpath(__file__)) +
                           "/datas")


def test_invoke():
    with open("%s/test.map" % datadir, "r") as f:
        mapfile = f.read().replace('{DATAPATH}', datadir)
    buf, content_type = mapserverapi.invoke(mapfile, qs)
    assert buf is not None
    assert len(buf) > 1000
    assert content_type == b"image/png"
    print("test_invoke ok")


def test_invoke_to_file():
    try:
        os.unlink("/tmp/test_mapserverapi_python")
    except Exception:
        pass
    with open("%s/test.map" % datadir, "r") as f:
        mapfile = f.read().replace('{DATAPATH}', datadir)
    ct = mapserverapi.invoke_to_file(mapfile, qs,
                                     "/tmp/test_mapserverapi_python")
    assert ct == b"image/png"
    assert os.path.isfile("/tmp/test_mapserverapi_python")
    with open("/tmp/test_mapserverapi_python", "rb") as f:
        content = f.read()
        assert len(content) > 1000
    os.unlink("/tmp/test_mapserverapi_python")
    print("test_invoke_to_file ok")


test_invoke()
test_invoke_to_file()
